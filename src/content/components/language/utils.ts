import { Entity, Field, Method, Node, Package, buildEnvironment } from 'wollok-ts'
import { last, match, when } from 'wollok-ts/dist/extensions'

const expectedSort = ['lang', 'lib', 'game' /* ... and the rest */]
function sortPackages() {
    const packages = buildEnvironment([]).getNodeByFQN<Package>('wollok').members as Package[]
    // Next line has effect
    packages.sort((p1, p2) => {
        if (!expectedSort.includes(p1.name)) return 999
        if (!expectedSort.includes(p2.name)) return -1
        return expectedSort.indexOf(p1.name) - expectedSort.indexOf(p2.name)
    })
    return packages
}

export const wollokPackages = sortPackages()

export const wollokHeadings = wollokPackages.flatMap(pkg => ([
  buildHeading(2)(pkg),
  ...pkg.members.map(buildHeading(3))
]))

function buildHeading(depth: number): (node: Package | Entity) => { depth: number, slug: string, text: string } {
    return (node) => ({
        depth,
        slug: node.fullyQualifiedName,
        text: node.name ?? node.fullyQualifiedName,
    })
}

export function methodLabel(method: Method) {
    return `${method.name}(${method.parameters.map(param => param.name).join(', ')})`
}

export function wollokDoc(node: Node): string {
    const comment = commentMetadataFor(node)
    return comment?.args['text'] as string ?? '<i>Documentation not found</i>'
}

function commentMetadataFor(node: Node) {
    const inlinedReturn = (method: Method): Node => {
        const lastSentence = last(method.sentences)!
        return lastSentence.descendants.find(_ => _.metadata.length > 0) ?? method
    }
    // Solves bug on parsing start/end comments
    const index = node.parent.children.indexOf(node)
    // First child has its comment as 'start'
    if (index == 0) return node.metadata.find(_ => _.name == 'comment' && _.args['position'] == 'start')
    // Next children have their comment as 'end' of the before
    const before = node.parent.children[index - 1]
    const commentedNode = match(before)<Node, any>(
        when(Method)(method => !method.isConcrete()
            ? method
            : (method.body.metadata.length > 0
                ? method.body
                : inlinedReturn(method))),
        when(Field)(field => field.value.isSynthetic ? field : field.value),
        when(Node)(_ => _)
    )
    return commentedNode?.metadata.find(_ => _.name == 'comment' && _.args['position'] == 'end')
}