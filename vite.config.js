import { defineConfig } from 'vite'
import elmPlugin from 'vite-plugin-elm'
import { ViteWebfontDownload } from 'vite-plugin-webfont-dl'
import { ViteFaviconsPlugin } from 'vite-plugin-favicon'
import { imagetools } from 'vite-imagetools'
import compress from 'vite-plugin-compress'

export default defineConfig({
  plugins: [
    elmPlugin(),
    ViteWebfontDownload(),
    ViteFaviconsPlugin({
      logo: './src/img/aa.svg', // svg works too!
      favicons: {
        appName: 'aner_andros',
        appDescription: 'Aner Andros home page',
        developerName: 'Andrea Callea',
        developerURL: null, // prevent retrieving from the nearest package.json
        icons: {
          coast: false,
          yandex: false,
          windows: false
        }
      }
    }),
    imagetools()
    // compress() // bug: https://github.com/alloc/vite-plugin-compress/issues/10
  ]
})
