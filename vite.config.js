import { defineConfig } from 'vite'
import elmPlugin from 'vite-plugin-elm'
import { ViteFaviconsPlugin } from 'vite-plugin-favicon'
import compress from 'vite-plugin-compress'

export default defineConfig({
  plugins: [
    elmPlugin(),
    compress(),
    ViteFaviconsPlugin({
      logo: './src/img/aner_andros-big.jpg', // svg works too!
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
    })
  ],
  build: {
    outDir: 'public'
  }
})
