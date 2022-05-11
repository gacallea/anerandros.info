module.exports = {
  content: [
    './index.html',
    './src/js/main.js',
    './src/css/styles.css',
    './src/elm/*.elm'
  ],
  theme: {
    extend: {},
    fontFamily: {
      sans: ['Lexend Deca', 'Helvetica', 'Arial', 'sans-serif']
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
