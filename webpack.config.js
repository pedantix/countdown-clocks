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
       test: /\.m?js$/,
       exclude: /(node_modules|bower_components)/,
       use: {
         loader: 'babel-loader',
         options: {
           presets: ['@babel/preset-env']
         }
       }
     },
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
        },// TODO: Minify CSS, consider the following
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({filename: "[name].css"}),
  ],
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
};
