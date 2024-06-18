module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#facc15",
          "secondary": "#fb923c",
          "accent": "#f87171",
          "neutral": "#a8a29e",
          "base-100": "#44403c",
          "info": "#38bdf8",
          "success": "#10b981",
          "warning": "#fbbf24",
          "error": "#ef4444",
        },
      },
    ],
  }
}
