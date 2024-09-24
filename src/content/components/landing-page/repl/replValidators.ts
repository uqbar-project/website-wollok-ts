import { type Problem } from 'wollok-ts'

export const showError = (error: any) => 
  ({
    row: 0,
    column: 0,
    text: error,
    type: 'error'
  })

export const showProblem = (problem: Problem) => {
  const start = problem.sourceMap?.start
  return {
    row: start ? start.line - 1 : 0,
    column: start?.column ?? 0,
    text: reportValidationMessage(problem) ?? 'Unexpected Error',
    type: problem.level
  }
}

// ************************************************************************************************************
// TODO: migrate from wollok-lsp-ide > reporter to wollok-web-tools
const convertToHumanReadable = (code: string) => {
  if (!code) {
    return ''
  }
  const result = code.replace(
    /[A-Z0-9]+/g,
    (match) => ' ' + match.toLowerCase()
  )
  return (
    result.charAt(0).toUpperCase() +
    result.slice(1, result.length)
  )
}

const interpolateValidationMessage = (message: string, ...values: string[]) =>
  message.replace(/{\d*}/g, (match: string) => {
    const index = match.replace('{', '').replace('}', '') as unknown as number
    return values[index] || ''
  })

const getMessage = (message: string, values: string[]): string =>
  interpolateValidationMessage(convertToHumanReadable(message), ...values)

export const reportValidationMessage = (problem: Problem): string =>
  getMessage(problem.code, problem.values.concat())

// ************************************************************************************************************
