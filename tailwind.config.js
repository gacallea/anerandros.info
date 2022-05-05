module.exports = {
  content: [
    './src/**/*.elm',
    './src/index.js',
    './src/index.html',
    './src/css/styles.css'
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
