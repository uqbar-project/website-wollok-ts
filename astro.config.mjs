import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  site: "https://uqbar-project.github.io",
  base: "/website-wollok-ts",
  integrations: [
    starlight({
      title: "Wollok",
      favicon: "/favicon.ico",
      logo: {
        light: "./src/assets/imagotipo-wollok.png",
        dark: "./src/assets/imagotipo-wollok-neg.png",
        replacesTitle: true,
      },
      // Set English as the default language for this site.
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
        github: "https://github.com/uqbar-project/wollok",
        discord: "https://discord.gg/9vMbuabnuc",
        twitter: "https://twitter.com/wollokLang",
      },
      sidebar: [
        {
          label: "Comenzando con Wollok",
          autogenerate: { directory: "gettingstarted" },
          // items: [
          //   // Each item here is one entry in the navigation menu.
          //   { label: "Example Guide", link: "/guides/example/" },
          // ],
        },
        {
          label: "Documentación",
          autogenerate: { directory: "documentation" },
        },
      ],
    }),
  ],
});
