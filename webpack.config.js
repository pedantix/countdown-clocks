const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: {
    main: './src/app.js',
    noscript: "./src/noscript.js"
  },
  output: {
     filename: '[name].js',
     path: __dirname + '/Public'
  },
  module: {
    rules: [
        {
          test: /\.(sa|sc|c)ss$/,
          use: [
            {
              loader: MiniCssExtractPlugin.loader,
              options: {
                hmr: process.env.NODE_ENV === 'development',
              },
            },
            'css-loader',
            'sass-loader',
          ],
        },
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({filename: "[name].css"}),
  ]
};
