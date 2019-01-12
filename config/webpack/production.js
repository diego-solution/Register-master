// const environment = require('./environment')
// module.exports = environment.toWebpackConfig()
// const merge = require('webpack-merge')
const environment = require('./environment')

const config = environment.toWebpackConfig()
// config.devtool = 'sourcemap'
// config.devtool = 'nosources-source-map'
config.devtool = 'none'
module.exports = config
