import { type Problem } from 'wollok-ts'

export const showProblem = (problem: Problem) => {
  const start = problem.sourceMap?.start
  return {
    row: start ? start.line - 1 : 0,
    column: start?.column ?? 0,
    text: reportValidationMessage(problem) ?? 'Unexpected Error',
    type: problem.level,
  }
}

// ************************************************************************************************************
// TODO 0: JSON mapping error codes with error messages i18ned
// TODO 1: migrate from wollok-lsp-ide > reporter to wollok-ts
// TODO 2: use it from here
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
