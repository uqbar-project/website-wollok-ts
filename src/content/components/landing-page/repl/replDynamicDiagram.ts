import type { ElementDefinition } from "cytoscape"
import { getDynamicDiagramData, Interpreter, LIST_MODULE, Package, SET_MODULE, WOLLOK_EXTRA_STACK_TRACE_HEADER, type DynamicDiagramElement, type DynamicDiagramNode, type DynamicDiagramReference } from "wollok-ts"

/* Copied from ts-cli => should be migrated to wollok web tools */
export const getDataDiagram = (interpreter: Interpreter, rootFQN?: Package): ElementDefinition[] =>
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


// Copied from utils.ts - wollok-ts-cli - should move to wollok-ts? (or wollok-web-tools)
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
