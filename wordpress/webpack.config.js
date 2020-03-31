const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    // core
    corejs: './wp-content/themes/co2ken/assets/js/services/corejs.ts',
    app: './wp-content/themes/co2ken/assets/js/app.ts',
    // templates

  },
  watch: true,
  module: {
    rules: [{
      test: /\.ts(x?)$/,
      exclude: /node_modules/,
      use: 'ts-loader'
    },
    {
      test: /\.js?$/,
      include: __dirname + '/wp-content/themes/co2ken/assets/js/',
      use: {
        loader: 'babel-loader',
        options: {
          "presets": [
            "@babel/preset-env", {
              useBuiltIns: 'usage',
              corejs: 3
            }
          ],
          "plugins": ["@babel/plugin-syntax-dynamic-import"]
        }
      }
    },
    {
      test: /\.js$/,
      use: ['source-map-loader'],
      enforce: 'pre'
    }
    ]
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  output: {
    filename: '[name].bundle.js',
    chunkFilename: '[name].[chunkhash].js',
    publicPath: '/wp-content/themes/co2ken/assets/js/bundles/',
    path: __dirname + '/wp-content/themes/co2ken/assets/js/bundles/',
  }
}