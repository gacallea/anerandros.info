# Aner Andros

Aner Andros' [home page](https://anerandros.info/). Designed with [Love](https://media.giphy.com/media/LiF9FQHuQ7owp6qxj9/giphy.gif), [Elm](https://elm-lang.org/), and [Tailwind CSS](https://tailwindcss.com/).

## Tooling

This repository/code is very opinionated. The following tools and provided configurations makes it very easy to be ready in no time.

### Elm

- [Elm Tooling](https://elm-tooling.github.io/elm-tooling-cli/)
- [Elm Format](https://github.com/avh4/elm-format)
- [Elm Test](https://package.elm-lang.org/packages/elm-explorations/test/latest/)
- [Elm Review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/)

### Others

- [NodeJS is managed with NVM](https://github.com/nvm-sh/nvm)
- [Vite](https://vitejs.dev/) (setup inspired by [Lindsay K Wardell](https://github.com/lindsaykwardell/vite-elm-template))
- [Tailwind CSS](https://tailwindcss.com/)
- [PostCSS](https://postcss.org/)

### VS Code

This repo provides recommended workspace extensions and settings. VS Code will prompt you to install them when you open the workspace for the first time. You should install them to adhere to this project coding standards.

#### Linters and Formatting

- [Standard JS](https://standardjs.com/)
- [Stylelint](https://stylelint.io/)
- [Prettier](https://prettier.io/)

## Development

Should you **wisely** have ```npm install --ignore-scripts``` active, you should temporarily disable it because 1) ```postinstall``` would not run, and 2) sharpjs will fail installing correctly. Apologies on behalf of sharpjs.

1. Clone the template locally:

   - ```git clone https://github.com/gacallea/anerandros.info.git```

2. Enter the project, install dependencies:

   - ```cd anerandros```
   - ```npm install```

3. Get started with development:

   - ```npm run dev```
