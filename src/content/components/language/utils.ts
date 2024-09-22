import { Class, Entity, Field, Method, Mixin, Node, Package, Singleton, buildEnvironment } from 'wollok-ts'
import { last, match, when, type List } from 'wollok-ts'

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

const wollokEntitiesRelevantMembers = (entity: Entity): List<Field|Method> => (match(entity)(
  when(Singleton)(singleton => singleton.members),
  when(Class)(klass => klass.members),
  when(Mixin)(mixin => mixin.members),
  when(Node)(_ => [])
) as List<Field|Method>).filter(node => !node.isSynthetic)

export const wollokHeadings = wollokPackages.flatMap(pkg => ([
  buildHeading(2)(pkg),
  ...pkg.members.flatMap(member => ([
    buildHeading(3)(member),
    ...wollokEntitiesRelevantMembers(member).map(buildHeading(4))
  ])),
]))

export function identifier(node: Package | Entity | Field | Method): string {
  return match(node)(
    when(Package)(pkg => pkg.fullyQualifiedName),
    when(Entity)(entity => entity.fullyQualifiedName),
    when(Field)(field => `${field.parent.fullyQualifiedName}.${field.name}`),
    when(Method)(method => method.label),
  )
}

function buildHeading(depth: number): (node: Package | Entity | Field | Method) => { depth: number, slug: string, text: string } {
    return (node) => ({
        depth,
        slug: identifier(node),
        text: node.name ?? identifier(node),
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