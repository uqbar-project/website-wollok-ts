import type { ElementDefinition } from 'cytoscape'
import { getDynamicDiagramData, Interpreter, Package, WOLLOK_EXTRA_STACK_TRACE_HEADER } from 'wollok-ts'
import { getDataDiagram } from 'wollok-web-tools'

export function getDynamicDiagram(interpreter: Interpreter, rootFQN?: Package): ElementDefinition[] {
  const objects = getDynamicDiagramData(interpreter, rootFQN)
  return getDataDiagram(objects)
}

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
