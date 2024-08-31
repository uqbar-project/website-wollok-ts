import './ReplEvaluator.css'
import { useState, type KeyboardEvent } from 'react'
import { Package, link, Interpreter, Evaluation, WRENatives } from 'wollok-ts'

const replPackage = new Package({ name: 'repl' })
const environment = link([replPackage])
new Interpreter(Evaluation.build(environment, WRENatives))

export const ReplEvaluator = () => {
  const [result, setResult] = useState(0)
  const [resultClass, setResultClass] = useState('ok')
  
  const evaluate = () => {
    // @ts-ignore
    console.info('el codigo es', document.getElementsByClassName('ace_text-layer')[0].innerText)
    setResult(Math.random() * 100)
    setResultClass('error')
  }

  const keyDown = (event: KeyboardEvent<HTMLInputElement>) => {
    if (event.key == 'Enter') {
      evaluate()
    }
  }

  return <section className="repl">
    <div className="line" id="editor">
      <input type="text" className="expression" onKeyDown={keyDown}></input>
      <button className="evaluate" onClick={() => evaluate()}>Evaluar</button>
    </div>
    <div className={`result ${resultClass}`}>{result}</div>
  </section>
}