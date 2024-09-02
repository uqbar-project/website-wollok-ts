import './ReplEvaluator.css'
import { useState, type ChangeEvent, type KeyboardEvent } from 'react'
import { Package, link, Interpreter, Evaluation, WRENatives } from 'wollok-ts'

const replPackage = new Package({ name: 'repl' })
const environment = link([replPackage])
new Interpreter(Evaluation.build(environment, WRENatives))

const results: Result[] = [
  { errored: false, result: 'true' },
  { errored: true, result: 'pepita does not understand volar' },
  { errored: false, result: '5' },
  { errored: true, result: 'Unknown reference pepita' },
  { errored: false, result: '' },
  { errored: false, result: '08/21/2024' },
]

const generateResult = (expression: string, { errored, result }: { errored: boolean, result: string }) =>
  !expression ?
  <>
    <div> </div>
  </> :
  <>
    <div className="normal">{expression}</div>
    <div className={errored ? 'error' :  'ok'}>
      {errored ? '✗' : '✓'} {result}
    </div>
  </>

// TODO: import from wollok-ts
type Result = {
  errored: boolean,
  error?: Error,
  result: string,
}

export const ReplEvaluator = () => {
  const [expression, setExpression] = useState('')
  const [oldExpression, setOldExpression] = useState('')
  const [history, setHistory] = useState<string[]>([])
  const [result, setResult] = useState<Result>({ errored: false, result: '' })
  const fontFamily = document.getElementsByClassName('ace_content')

  console.info(fontFamily)

  const evaluate = () => {
    // @ts-ignore
    // console.info('el codigo es', document.getElementsByClassName('ace_text-layer')[0].innerText)
    setHistory(history.concat(expression))
    setResult(results[Math.trunc(Math.random() * 6)]!)
    setOldExpression(expression)
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
        <button className="refresh" onClick={() => reloadAndRefresh()} title="Recarga el editor e inicia una nueva sesión del REPL">
          <img src="/src/assets/repl/refresh.svg"/>
        </button>
        <button className="reload" onClick={() => reload()} title="Recarga el editor y ejecuta la última sesión activa">
          <img src="/src/assets/repl/reload.svg"/>
        </button>
      </div>
    </div>
    <div className='result'>
      {generateResult(oldExpression, result)}
    </div>
  </section>
}