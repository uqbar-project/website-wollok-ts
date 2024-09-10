import './ReplEvaluator.css'
import { useState, type ChangeEvent, type KeyboardEvent } from 'react'
import { Package, link, Interpreter, Evaluation, WRENatives, type ExecutionResult, interprete, REPL, WRE, fromJSON } from 'wollok-ts'

const replPackage = new Package({ name: REPL })
const environment = link([replPackage], fromJSON(WRE))
const interpreter = new Interpreter(Evaluation.build(environment, WRENatives))

const interpreteLine = (expression: string) => {
  return interprete(interpreter, expression)
}

export const ReplEvaluator = () => {
  const [expression, setExpression] = useState('')
  const [history, setHistory] = useState<string[]>([])
  const [formattedResult, setFormattedResult] = useState<JSX.Element | undefined>(undefined)

  const generateResult = (expression: string, { errored, result, error }: ExecutionResult) =>
    !expression ? 
    undefined :
    <div key={expression}>
      <div className="normal">{expression}</div>
      <div className={errored ? 'error' :  'ok'}>
        {errored ? '✗' : '✓'} {result} {error?.message}
      </div>
    </div>
  
  const evaluate = () => {
    // @ts-ignore
    // console.info('el codigo es', document.getElementsByClassName('ace_text-layer')[0].innerText)
    setHistory(history.concat(expression))
    const result = interpreteLine(expression)
    setFormattedResult(generateResult(expression, result))
    setExpression('')
  }

  const keyDown = (event: KeyboardEvent<HTMLInputElement>) => {
    if (event.key == 'Enter') {
      evaluate()
    }
  }

  const expressionChanged = (event: ChangeEvent<HTMLInputElement>) => {
    setExpression(event.target.value)
  }

  const reloadAndRefresh = () => {
    const newResult = <div>
      {
      history.map((expression: string) =>
        generateResult(expression, interpreteLine(expression)))
      }
    </div>
    setFormattedResult(newResult)
    setExpression('')
  }

  const reload = () => {}

  return <section className="repl">
    <div className="line" id="editor">
      <input type="text" className="expression" onKeyDown={keyDown} onChange={expressionChanged} value={expression}></input>
      <div className="botonera">
        <button className="evaluate" onClick={() => evaluate()} title="Evaluar la expresión">
          {/* https://github.com/feathericons/feather/blob/main/icons */}
          <img src="/src/assets/repl/evaluate.svg"/>
        </button>
        <button className="refresh" onClick={() => reload()} title="Recarga el editor e inicia una nueva sesión del REPL">
          <img src="/src/assets/repl/refresh.svg"/>
        </button>
        <button className="reload" onClick={() => reloadAndRefresh()} title="Recarga el editor y ejecuta la última sesión activa">
          <img src="/src/assets/repl/reload.svg"/>
        </button>
      </div>
    </div>
    {formattedResult && <div className='result'>
      {formattedResult}
    </div>}
  </section>
}