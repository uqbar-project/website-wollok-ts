import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import * as fs from "fs";

import react from "@astrojs/react";

// https://astro.build/config
export default defineConfig({
  site: "https://uqbar-project.github.io",
  base: "/",
  integrations: [starlight({
    title: "Wollok",
    description: "The official Wollok language website.",
    expressiveCode: {
      shiki: {
        langs: [JSON.parse(fs.readFileSync("./src/shiki-grammars/wollok.json", "utf-8"))]
      }
    },
    favicon: "/favicon.ico",
    logo: {
      light: "./src/assets/branding/imagotipo-pos.svg",
      dark: "./src/assets/branding/imagotipo-neg.svg",
      replacesTitle: true
    },
    customCss: ["./src/styles/custom-theme.css", "./src/styles/global-styles.css"],
    defaultLocale: "root",
    locales: {
      root: {
        label: "Español",
        lang: "es"
      },
      en: {
        label: "English"
      }
    },
    social: [
      { icon: 'github', label: 'GitHub', href: 'https://github.com/uqbar-project/wollok-language' },
      { icon: 'discord', label: 'Discord', href: 'https://discord.gg/ZstgCPKEaa' },
      { icon: 'twitter', label: 'Twitter', href: 'https://twitter.com/wollokLang' },
    ],
    components: {
      Footer: "./src/content/components/Footer.astro"
    },
    sidebar: [{
      label: "Comenzando con Wollok",
      autogenerate: {
        directory: "getting_started"
      }
    }, {
      label: "Tour",
      autogenerate: {
        directory: "tour"
      }
    }, {
      label: "Documentación",
      items: [{
        label: "Introducción",
        link: "documentation/introduction"
      }, {
        label: "Objetos",
        link: "documentation/objects"
      }, {
        label: "Tests",
        link: "documentation/tests"
      }, {
        label: "Colecciones",
        link: "documentation/collections"
      }, {
        label: "Clases",
        link: "documentation/classes"
      }, {
        label: "Wollok Game",
        link: "documentation/wollok_game"
      }, {
        label: "Avanzado",
        link: "documentation/advanced"
      }, {
        label: "Guía del lenguaje",
        link: "/documentation/language",
        badge: {
          text: "WollokDoc",
          variant: "danger"
        }
      }]
    }, {
      label: "Material",
      autogenerate: {
        directory: "material"
      }
    },{
      label: "Novedades",
      autogenerate: {
        directory: "news"
      }
    }, {
      label: "Quiero saber más",
      link: "/more_info"
    }]
  }), react()]
});
