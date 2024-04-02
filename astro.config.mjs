import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  site: "https://uqbar-project.github.io",
  base: "/website-wollok-ts",
  integrations: [
    starlight({
      title: "Wollok",
      description: "The official Wollok language website.",
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
        github: "https://github.com/uqbar-project/wollok",
        discord: "https://discord.gg/9vMbuabnuc",
        twitter: "https://twitter.com/wollokLang",
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
