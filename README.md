
## Wollok Web Site

[![Deploy to GitHub Pages](https://github.com/uqbar-project/website-wollok-ts/actions/workflows/deploy.yaml/badge.svg)](https://github.com/uqbar-project/website-wollok-ts/actions/workflows/deploy.yaml) [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Wollok Programming Language Web Site - TS implementation

Access it at : http://www.wollok.org

If you are looking for the Wollok Xtext Implementation Site, please visit http://xtext.wollok.org

## Technologies

- [Astro + Starlight](https://starlight.astro.build)
  - [Starlight’s docs](https://starlight.astro.build/)
  - [Astro documentation](https://docs.astro.build)

## 🚀 Project Structure

Like any Astro + Starlight project, you'll see the following folders and files:

```bash
.
├── public/
├── src/
│   ├── assets/
│   ├── content/
│   │   ├── docs/
│   │   └── config.ts
│   └── env.d.ts
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

- starlight looks for `.md` or `.mdx` files in the `src/content/docs/` directory.
- each file is exposed as a route based on its file name.
- images can be added to `src/assets/` and embedded in Markdown with a relative link.
- static assets, like favicons, can be placed in the `public/` directory.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

## 🚀 Site deployment

Just push into the main branch and it automatically deploys using Github pages.

For more information please check [deploy.yaml](./.github/workflows/deploy.yaml) file.

## 💻 Developer environment

You will need an Astro editor. We recomend [Visual Studio Code](https://code.visualstudio.com/) with some extensions.

You can [download and import this profile](./Astro%20-Base.code-profile) in your Visual Studio Code. See this tutorial if you have any question.

### Alternative: manually install VSC extensions

Make sure you install the following extensions:

- [Astro Essentials Extension Pack - Manuel Gil](https://marketplace.visualstudio.com/items?itemName=imgildev.vscode-astro-pack)
- [Astro DB snippets - Manuel Gil](https://marketplace.visualstudio.com/items?itemName=SheltonLouis.astro-snippets)
- [:Emojisense: - Matt Bierner](https://marketplace.visualstudio.com/items?itemName=bierner.emojisense)

### Installing node, npm & nvm

Follow the instructions on [Wollok TS page](https://uqbar-project.github.io/wollok-ts/pages/How-To-Contribute/Developer-environment.html) about installing Node, NPM & nvm.

## 👩‍💻 Contributing

All contributions are welcome!

- You can [join the Discord channel!](https://discord.gg/ZstgCPKEaa)
- There's a list of [good first issues](https://github.com/uqbar-project/website-wollok-ts/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) to tackle, but in case of any hesitation you can always ping @PalumboN or @fdodino
- You can fork the project and [create a *Pull Request*](https://help.github.com/articles/creating-a-pull-request-from-a-fork/). If you've never collaborated with an open source project before, you might want to read [this guide](https://akrabat.com/the-beginners-guide-to-contributing-to-a-github-project/)

__Powered by [Uqbar](https://uqbar.org/)__
