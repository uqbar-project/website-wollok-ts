import { useState, type ChangeEvent, type KeyboardEvent } from 'react'
import { Evaluation, Interpreter, Package, REPL, WOLLOK_FILE_EXTENSION, WRE, WRENatives, fromJSON, interprete, link, parse, validate, type ExecutionResult } from 'wollok-ts'
import { getDataDiagram, sanitizeStackTrace } from './replDynamicDiagram'
import './ReplEvaluator.css'

const buildEnvironment = (aPackage: Package) => {
  const environment = link([aPackage], fromJSON(WRE))
  return new Interpreter(Evaluation.build(environment, WRENatives))
}

const buildInterpreter = () => {
  try {
    // @ts-ignore
    const content = getEditorContent()
    const replPackage = parse.File(REPL + '.' + WOLLOK_FILE_EXTENSION).tryParse(content)
    const interpreter = buildEnvironment(replPackage)
    const problems = validate(interpreter.evaluation.environment)
    // @ts-ignore
    showErrors(problems.map(problem => showProblem(problem)))
    return interpreter
  } catch (e) {
    console.info(e)
    // @ts-ignore
    showErrors([showError(e)])
    return buildEnvironment(new Package({ name: REPL }))
  }
}

let interpreter = buildInterpreter()

const interpreteLine = (expression: string) => {
  return interprete(interpreter!, expression)
}

export const ReplEvaluator = () => {
  const [expression, setExpression] = useState('')
  const [history, setHistory] = useState<string[]>([])
  const [indexExpression, setIndexExpression] = useState(history.length)
  const [formattedResult, setFormattedResult] = useState<JSX.Element | undefined>(undefined)

  const generateResult = (expression: string, { errored, result, error }: ExecutionResult) =>
    !expression ?
    undefined :
    <div key={Math.random() * 10000000000}>
      <div className="normal">{expression}</div>
      <div className={errored ? 'error' :  'ok'}>
        {errored ? '✗' : '✓'} {result} {sanitizeStackTrace(error)}
      </div>
    </div>

  const evaluate = () => {
    if (!expression) return
    const newHistory = history.concat(expression)
    setHistory(newHistory)
    setIndexExpression(newHistory.length)
    const result = interpreteLine(expression)
    setFormattedResult(generateResult(expression, result))
    setExpression('')
    refreshDynamicDiagram()
  }

  const refreshDynamicDiagram = () => {
    const elements = getDataDiagram(interpreter)
    // @ts-ignore
    reloadDiagram(elements)
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
    const newResult = <div>
      {
      history.map((expression: string) =>
        generateResult(expression, interpreteLine(expression)))
      }
    </div>
    setFormattedResult(newResult)
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
    interpreter = buildInterpreter()
  }

  return <section className="repl">
    <div className="replLine" id="editor">
      <input type="text" className="replExpression" onKeyDown={keyDown} onChange={expressionChanged} value={expression}></input>
      <div className="botoneraReplExpression">
        <button className="replEvaluate" onClick={() => evaluate()} title="Evaluar la expresión">
          {/* https://github.com/feathericons/feather/blob/main/icons */}
          <img src="/src/assets/repl/evaluate.svg"/>
        </button>
        <button className="replRefresh" onClick={() => reload()} title="Recarga el editor e inicia una nueva sesión del REPL">
          <img src="/src/assets/repl/refresh.svg"/>
        </button>
        <button className="replReload" onClick={() => reloadAndRefresh()} title="Recarga el editor y ejecuta la última sesión activa">
          <img src="/src/assets/repl/reload.svg"/>
        </button>
      </div>
    </div>
    {formattedResult && <div className='replResult'>
      {formattedResult}
    </div>}
  </section>
}

