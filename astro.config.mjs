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
        light: "./src/assets/branding/imagotipo-pos.svg",
        dark: "./src/assets/branding/imagotipo-neg.svg",
        replacesTitle: true,
      },
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
          autogenerate: { directory: "getting_started" },
          // items: [
          //   // Each item here is one entry in the navigation menu.
          //   { label: "Example Guide", link: "/guides/example/" },
          // ],
        },
        {
          label: "Tour",
          autogenerate: { directory: "tour" },
        },
        {
          label: "Documentación",
          autogenerate: { directory: "documentation" },
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
