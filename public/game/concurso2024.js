const parent = document.getElementById('game')
const project = document.location.pathname.split('/').filter(x => x).slice(-1)[0]

const BASE_FOLDER = '/concurso2024/'
const GAMES_FILE = BASE_FOLDER + project + '.txt'
const PROJECT_FOLDER = BASE_FOLDER + project + '/'
const ASSETS_FOLDER = 'assets/'

fetch(GAMES_FILE)
    .then(res => res.text())
    .then(str => str.split('\n'))
    .then(files => loadProject(PROJECT_FOLDER, files))

function loadProject(baseFolder, fileNames) {
    const wollokFiles = fileNames.filter(name => name.match(/.(wlk|wpgm)/))
    Promise.all(
        wollokFiles.map(name =>
            fetch(baseFolder + name)
                .then(res => res.text())
                .then(content => ({ name, content })))
    )
    .then(sources => {
        const assets = fileNames
            .filter(name => name.startsWith(ASSETS_FOLDER))
            .map(name => ({
                possiblePaths: [name.slice(ASSETS_FOLDER.length)],
                url: PROJECT_FOLDER + name
            }))
        
        const sounds = assets.filter(({url}) => url.match(/.(mp3|wav)/))
        const images = assets.filter(({url}) => !url.match(/.(mp3|wav)/))
        const { name: mainFile } = sources.find(({name}) => name.endsWith('.wpgm'))
        const main = mainFile.slice(0, -4).replaceAll('/', '.')
        return [main, sources, images, sounds]
    })
    .then(([main, sources, images, sounds]) => ({ main, sources, images, sounds }))
    .then(project => {
        parent.childNodes[0].remove()
        new LocalGame(project).start(parent)
    })

}
