import { Annotation, Class, Entity, Field, Method, Mixin, Node, Package, Singleton, buildEnvironment, last } from 'wollok-ts'
import { match, when, type List } from 'wollok-ts'

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

const wollokEntitiesRelevantMembers = (entity: Entity): List<Field | Method> => (match(entity)(
  when(Singleton)(singleton => singleton.members),
  when(Class)(klass => klass.members),
  when(Mixin)(mixin => mixin.members),
  when(Node)(_ => [])
) as List<Field | Method>).filter(node => !node.isSynthetic)

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
  return comment?.args['text'] as string ?? ''
}

function commentMetadataFor(node: Node) {
  // Solves bug on parsing start/end comments
  const getPreviousSiblingMetadata = (method: Method): Annotation | undefined => {
    const siblingIndex = method.parent.methods.indexOf(method) - 1
    const siblingMethod = method.parent.methods[siblingIndex]
    if (!siblingMethod) return undefined
    const lastSentence = last(siblingMethod.sentences)!
    const childWithMetadata = lastSentence?.descendants?.find(_ => _.metadata.length)
    return childWithMetadata ? getMetadata(childWithMetadata) : siblingMethod.metadata[1] ?? siblingMethod.metadata[0]
  }

  const getMetadata = (node: Node) => node.metadata.find(({ name, args }: Annotation) => name == 'comment' && (args['position'] == 'start' || (args['position'] == 'end' && !node.is(Method))))

  const getMetadataForNode = (node: Node) => {
    const parent = node.parent
    const siblingIndex = parent.children.indexOf(node) - 1
    const siblingNode = parent.children[siblingIndex]
    const metadata = siblingNode?.metadata.find(({ name, args }: Annotation) => name == 'comment' && args['position'] == 'end')
    return metadata ?? getMetadata(node)
  }

  return match(node)<Annotation | undefined, any>(
    when(Method)(method => getMetadata(method) ?? getPreviousSiblingMetadata(method)),
    when(Field)(getMetadataForNode),
    when(Class)(getMetadataForNode),
    when(Singleton)(getMetadataForNode),
    when(Node)(_ => getMetadata(_))
  )
}