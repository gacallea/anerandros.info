module.exports = {
  content: [
    './src/**/*.elm',
    './src/index.js',
    './src/index.html',
    './src/css/styles.css'
  ],
  theme: {
    extend: {}
  },
  plugins: [require('@tailwindcss/typography')]
}
