import { getMessage, LANGUAGES, type Problem } from 'wollok-ts'

export const showProblem = (problem: Problem) => {
  const start = problem.sourceMap?.start
  return {
    row: start ? start.line - 1 : 0,
    column: start?.column ?? 0,
    text: reportValidationMessage(problem) ?? 'Unexpected Error',
    type: problem.level,
  }
}

// TODO: use locale
const lang = () => LANGUAGES.SPANISH

export const reportValidationMessage = (problem: Problem): string =>
  getMessage({ message: problem.code, values: problem.values.concat(), language: lang() })
