module.exports = {
  content: [
    './src/index.html',
    './src/js/index.js',
    './src/css/styles.css',
    './src/elm/**/*.elm'
  ],
  theme: {
    extend: {},
    fontFamily: {
      sans: ['Lexend Deca', 'Helvetica', 'Arial', 'sans-serif'],
      display: ['Righteous']
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
