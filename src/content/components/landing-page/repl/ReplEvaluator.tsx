import { useEffect, useRef, useState, type ChangeEvent, type JSX, type KeyboardEvent } from 'react'
import { Evaluation, Interpreter, Package, REPL, RuntimeObject, TO_STRING_METHOD, WOLLOK_FILE_EXTENSION, WRE, fromJSON, get, interprete, link, natives, parse, validate, type Execution, type ExecutionResult, type NativeFunction, type Natives } from 'wollok-ts'
import { getDynamicDiagram, sanitizeStackTrace } from './replDynamicDiagram'
import './ReplEvaluator.css'
import { showProblem } from './replValidators'

// TODO: Use (or fix) the merge function
const newInterpreter = (aPackage: Package, printFunction: NativeFunction) => {
  const environment = link([aPackage], fromJSON(WRE))
  const native = natives()
  const console = get<Natives>(native, 'wollok.lib.console')!
  console['println'] = printFunction
  return new Interpreter(Evaluation.build(environment, native))
}

// i18n translations
const translations = {
  es: {
    refreshTitle: "Recarga el editor e inicia una nueva sesión del REPL",
    reloadTitle: "Recarga el editor y ejecuta la última sesión activa",
    evaluateTitle: "Evaluar la expresión",
    placeholder: "Escribí una expresión como 2.even() o pepita.estaCansada()"
  },
  en: {
    refreshTitle: "Reload the editor and start a new REPL session",
    reloadTitle: "Reload the editor and run the last active session",
    evaluateTitle: "Evaluate the expression",
    placeholder: "Write an expression like 2.even() or pepita.isTired()"
  }
}

const getLocale = (): 'es' | 'en' => {
  // Check URL path for locale
  if (typeof window !== 'undefined' && window.location.pathname.startsWith('/en')) {
    return 'en'
  }
  return 'es'
}

let interpreter: Interpreter
let log: string | null = null // from console

export const ReplEvaluator = () => {
  const locale = getLocale()
  const t = translations[locale]
  const [expression, setExpression] = useState('')
  const [history, setHistory] = useState<string[]>([])
  const [indexExpression, setIndexExpression] = useState(history.length)
  const [formattedResult, setFormattedResult] = useState<JSX.Element | undefined>(undefined)
  const resultRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (!interpreter) buildInterpreter()

    resultRef.current?.scroll({ top: resultRef.current?.scrollHeight, behavior: 'smooth' })
    refreshDynamicDiagram()
  }, [formattedResult])

  const generateResult = (expression: string, { errored, result, error }: ExecutionResult) =>
    !expression ?
      undefined :
      <div key={Math.random() * 10000000000}>
        <div className="normal">{expression}</div>
        <div className="normal">{log}</div>
        <div className={errored ? 'error' : 'ok'}>
          {errored ? '✗' : '✓'} {result} {sanitizeStackTrace(error)}
        </div>
      </div>

  const evaluate = () => {
    const sanitizedExpression = expression.trim()
    if (!sanitizedExpression) return
    const newHistory = history.concat(sanitizedExpression)
    setHistory(newHistory)
    setIndexExpression(newHistory.length)
    const result = interpreteLine(sanitizedExpression)
    setFormattedResult(<>
      {formattedResult}
      {generateResult(sanitizedExpression, result)}
    </>)
    log = null
    setExpression('')
    refreshDynamicDiagram()
  }

  const refreshDynamicDiagram = () => {
    const elements = getDynamicDiagram(interpreter)
    // @ts-ignore
    try { reloadDiagram(elements) } catch { }
  }

  const keyDown = (event: KeyboardEvent<HTMLInputElement>) => {
    if (event.key == 'Enter') {
      evaluate()
    }
    if (event.key == 'ArrowUp') {
      goBackExpression()
    }
    if (event.key == 'ArrowDown') {
      goForwardExpression()
    }
  }

  const goBackExpression = () => {
    const newIndex = Math.max(0, indexExpression - 1)
    setNewIndex(newIndex)
  }

  const goForwardExpression = () => {
    const newIndex = Math.min(history.length, indexExpression + 1)
    setNewIndex(newIndex)
  }

  const setNewIndex = (newIndex: number) => {
    setIndexExpression(newIndex)
    setExpression(history[newIndex] ?? '')
  }

  const expressionChanged = (event: ChangeEvent<HTMLInputElement>) => {
    setExpression(event.target.value)
  }

  const reloadAndRefresh = () => {
    reloadInterpreter()
    const newResult = <>
      {
        history.map((expression: string) =>
          generateResult(expression, interpreteLine(expression)))
      }
    </>
    setFormattedResult(history.length ? newResult : undefined)
    setExpression('')
    refreshDynamicDiagram()
  }

  const reload = () => {
    reloadInterpreter()
    refreshDynamicDiagram()
  }

  const reloadInterpreter = () => {
    setExpression('')
    setFormattedResult(undefined)
    buildInterpreter()
  }

  const interpreteLine = (expression: string) => {
    return interprete(interpreter!, expression)
  }

  // NATIVES
  const println: NativeFunction = function* (_self: RuntimeObject, obj: RuntimeObject): Execution<void> {
    const wollokString = yield* this.send(TO_STRING_METHOD, obj)
    const innerString = wollokString!.innerString!
    log = innerString
  }

  function buildInterpreter() {
    try {
      // @ts-ignore
      const content = getEditorContent()
      const replPackage = parse.File(REPL + '.' + WOLLOK_FILE_EXTENSION).tryParse(content)
      interpreter = newInterpreter(replPackage, println)
      const problems = validate(interpreter.evaluation.environment)

      // @ts-ignore
      showProblems(problems.map(problem => showProblem(problem)))
      // @ts-ignore
      markReplSessionSynced()
    } catch (e) {
      console.info(e)
      // @ts-ignore
      showError(e)
      interpreter = newInterpreter(new Package({ name: REPL }), println)
    }
  }

  return <section className="repl">
    {formattedResult && <div className='replResult' ref={resultRef}>
      {formattedResult}
    </div>}
    <div className="replLine">
      <div className="botoneraReplExpression">
        <button className="replRefresh" onClick={() => reload()} title={t.refreshTitle}>
          <img src="/repl/refresh.svg" />
        </button>
        <button className="replReload" onClick={() => reloadAndRefresh()} title={t.reloadTitle}>
          <img src="/repl/reload.svg" />
        </button>
        <button id="validateEditor" onClick={() => buildInterpreter()} />
      </div>
      <input type="text" className="replExpression" placeholder={t.placeholder} onKeyDown={keyDown} onChange={expressionChanged} value={expression}></input>
      <div className="botoneraReplExpression">
        <button className="replEvaluate" onClick={() => evaluate()} title={t.evaluateTitle}>
          {/* https://github.com/feathericons/feather/blob/main/icons */}
          <img src="/repl/evaluate.svg" />
        </button>
      </div>
    </div>
  </section>
}

