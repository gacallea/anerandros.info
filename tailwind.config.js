module.exports = {
  content: [
    './src/elm/*.elm',
    './src/js/main.js',
    './index.html',
    './src/css/styles.css'
  ],
  theme: {
    extend: {},
    fontFamily: {
      sans: ['Lexend Deca', 'Helvetica', 'Arial', 'sans-serif']
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
