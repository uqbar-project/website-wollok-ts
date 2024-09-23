import './ReplEvaluator.css'
import { useState, type ChangeEvent, type KeyboardEvent } from 'react'
import { Package, link, Interpreter, Evaluation, WRENatives, type ExecutionResult, interprete, REPL, WRE, fromJSON, getDynamicDiagramData, type DynamicDiagramElement, type DynamicDiagramNode, type DynamicDiagramReference, LIST_MODULE, SET_MODULE, WOLLOK_EXTRA_STACK_TRACE_HEADER, parse } from 'wollok-ts'
import type { ElementDefinition } from 'cytoscape'

// TODO: import internal buildEnvironment from wollok-ts
const buildInterpreter = () => {
  // @ts-ignore
  const content = document.getElementsByClassName('ace_text-layer')[0].innerText
  const replPackage = parse.File(REPL).tryParse(content)
  const environment = link([replPackage], fromJSON(WRE))
  return new Interpreter(Evaluation.build(environment, WRENatives))
}

let interpreter = buildInterpreter()

const interpreteLine = (expression: string) => {
  return interprete(interpreter, expression)
}

/**************************************************************************************************************************************************************/
/* Copied from ts-cli => should be migrated to wollok web tools */
const getDataDiagram = (interpreter: Interpreter, rootFQN?: Package): ElementDefinition[] =>
  getDynamicDiagramData(interpreter, rootFQN)
    .map((dynamicDiagramElement: DynamicDiagramElement) =>
      dynamicDiagramElement.elementType === 'node' ? convertToCytoscapeNode(dynamicDiagramElement as DynamicDiagramNode) : convertToCytoscapeReference(dynamicDiagramElement as DynamicDiagramReference)
    )

const convertToCytoscapeNode = ({ id, type, label }: DynamicDiagramNode): ElementDefinition => ({
  data: {
    id,
    label,
    type,
    fontsize: getFontSize(label),
  },
})

const convertToCytoscapeReference = ({ id, label, sourceId, targetId, sourceModule, constant }: DynamicDiagramReference): ElementDefinition => ({
  data: {
    id,
    label: `${label}${constant ? '🔒' : ''}`,
    source: sourceId,
    target: targetId,
    width: sourceModule ? 1 : 1.5,
    fontsize: getFontSize(label),
    style: getStyle(sourceModule ?? ''),
  },
})


const getFontSize = (text: string): string => {
  const textWidth = text.length
  if (textWidth > 8) return '7px'
  if (textWidth > 5) return '8px'
  return '9px'
}

const getStyle = (sourceModule: string) =>
  [LIST_MODULE, SET_MODULE].includes(sourceModule) ? 'dotted' : 'solid'


// Copied from utils.ts - wollok-ts-cli - should move to wollok-web-tools
export const sanitizeStackTrace = (e?: Error): string => {
  if (e?.message) {
    const originalMessage = e.message.split('\n')
    return originalMessage[0] ?? e.message
  }

  const indexOfTsStack = e?.stack?.indexOf(WOLLOK_EXTRA_STACK_TRACE_HEADER)
  const fullStack = e?.stack?.slice(0, indexOfTsStack ?? -1) ?? ''

  return fullStack
    .replaceAll('\t', '  ')
    .replaceAll('     ', '  ')
    .replaceAll('    ', '  ')
    .split('\n')
    .filter(stackTraceElement => stackTraceElement.trim())
    .join('\n')
}
/**************************************************************************************************************************************************************/

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
    // @ts-ignore
    // console.info('el codigo es', document.getElementsByClassName('ace_text-layer')[0].innerText)
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

