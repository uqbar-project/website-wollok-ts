import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import fs from "fs";

// https://astro.build/config
export default defineConfig({
  site: "https://uqbar-project.github.io",
  base: "/",
  integrations: [
    starlight({
      title: "Wollok",
      description: "The official Wollok language website.",
      expressiveCode: {
        shiki: {
          langs: [
            JSON.parse(
              fs.readFileSync("./src/shiki-grammars/wollok.json", "utf-8")
            ),
          ],
        },
      },
      favicon: "/favicon.ico",
      logo: {
        light: "./src/assets/branding/imagotipo-pos.svg",
        dark: "./src/assets/branding/imagotipo-neg.svg",
        replacesTitle: true,
      },
      customCss: [
        "./src/styles/custom-theme.css",
        "./src/styles/global-styles.css",
      ],
      defaultLocale: "root",
      locales: {
        root: {
          label: "Español",
          lang: "es",
        },
        en: {
          label: "English",
        },
      },
      social: {
        github: "https://github.com/uqbar-project/wollok-language",
        discord: "https://discord.gg/ZstgCPKEaa",
        twitter: "https://twitter.com/wollokLang",
      },
      components: {
        Footer: "./src/content/components/Footer.astro",
      },
      sidebar: [
        {
          label: "Comenzando con Wollok",
          autogenerate: { directory: "getting_started" },
        },
        {
          label: "Tour",
          autogenerate: { directory: "tour" },
        },
        {
          label: "Documentación",
          items: [
            {
              label: "Introducción a Wollok",
              link: "documentation/introduction",
            },
            { label: "Objetos", link: "documentation/objects" },
            { label: "Tests", link: "documentation/tests" },
            { label: "Colecciones", link: "documentation/collections" },
            { label: "Clases", link: "documentation/classes" },
            { label: "Wollok Game", link: "documentation/wollok_game" },
            { label: "Avanzado", link: "documentation/advanced" },
            {
              label: "Guía del lenguaje",
              link: "/documentation/language",
              badge: { text: "WollokDoc", variant: "danger" },
            },
          ],
        },
        {
          label: "Material",
          autogenerate: { directory: "material" },
        },
        { label: "Quiero saber más", link: "/more_info" },
      ],
    }),
  ],
});
