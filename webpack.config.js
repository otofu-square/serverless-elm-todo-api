const path = require('path');
const webpack = require('webpack');
const slsw = require('serverless-webpack');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

const config = {
  entry: slsw.lib.entries,
  target: 'node',
  output: {
    libraryTarget: 'commonjs',
    path: path.resolve(`${__dirname}/.build`),
    filename: '[name].js',
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [{ loader: 'elm-webpack-loader' }],
      },
    ],
  },
  plugins: [],
};

config.plugins =
  process.env.NODE_ENV === 'production'
    ? config.plugins
    : config.plugins.push(new UglifyJsPlugin());

module.exports = config;
