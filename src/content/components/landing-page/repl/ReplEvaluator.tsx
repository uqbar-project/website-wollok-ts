import './ReplEvaluator.css'
import { useState, type ChangeEvent, type KeyboardEvent } from 'react'
import { Package, link, Interpreter, Evaluation, WRENatives } from 'wollok-ts'

const replPackage = new Package({ name: 'repl' })
const environment = link([replPackage])
new Interpreter(Evaluation.build(environment, WRENatives))

export const ReplEvaluator = () => {
  const [result, setResult] = useState(0)
  const [resultClass, setResultClass] = useState('ok')
  const [expression, setExpression] = useState('')
  const [history, setHistory] = useState<string[]>([])

  const fontFamily = document.getElementsByClassName('ace_content')

  console.info(fontFamily)

  const evaluate = () => {
    // @ts-ignore
    console.info('el codigo es', document.getElementsByClassName('ace_text-layer')[0].innerText)
    setHistory(history.concat(expression))
    setResult(Math.random() * 100)
    setResultClass('error')
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

  const reloadAndRefresh = () => {}

  const reload = () => {}

  return <section className="repl">
    <div className="line" id="editor">
      <input type="text" className="expression" onKeyDown={keyDown} onChange={expressionChanged} value={expression}></input>
      <div className="botonera">
        <button className="evaluate" onClick={() => evaluate()} title="Evaluar la expresión">
          {/* https://github.com/feathericons/feather/blob/main/icons/alert-circle.svg */}
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
    <div className={`result ${resultClass}`}>{result}</div>
  </section>
}