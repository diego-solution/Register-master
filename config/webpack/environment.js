const { environment } = require('@rails/webpacker')
// resolve-url-loader must be used before sass-loader
// environment.loaders.get('sass').use.splice(-1, 0, {
//   loader: 'resolve-url-loader',
//   options: {
//     attempts: 1
//   }
// });

const { resolve } = require("path");

environment.loaders.get('sass')
  .use.find(item => item.loader === 'sass-loader').options.includePaths = [resolve("app", "javascript", "styles")]

const vue =  require('./loaders/vue')
environment.loaders.append('vue', vue)

// Add an additional plugin of your choosing : ProvidePlugin
// const webpack = require('webpack')
// environment.plugins.prepend(
//   'Provide',
//   new webpack.ProvidePlugin({
//     'window.Quill': 'quill'
//   })
//
//
// )

module.exports = environment
