import { Method, Node, Package, buildEnvironment } from 'wollok-ts'

const expectedSort = ['lang', 'lib', 'game' /* ... and the rest */]
function sortPackages() {
    const packages = buildEnvironment([]).getNodeByFQN<Package>('wollok').members as Package[]
    // Next line has effect
    packages.sort((p1, p2) => {
        if (!expectedSort.includes(p1.name)) return 999
        if (!expectedSort.includes(p2.name)) return -1
        return expectedSort.indexOf(p1.name) - expectedSort.indexOf(p2.name)})
    return packages
}

export const wollokPackages = sortPackages()

export function methodLabel(method: Method) {
    return `${method.name}(${method.parameters.map(param => param.name).join(', ')})`
}

export function wollokDoc(node: Node) {
    const comment = node.metadata.find(_ => _.name == 'comment')
    return comment?.args // .get('text')
}