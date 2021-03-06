import { join } from 'path';

export default {
  entry: {
    app: [
      "./web/static/js/app.js",
      "./web/static/elm/Main.elm"
    ],
    login: [
      "./web/static/js/login.js"
    ]
  },
  output: {
    path: "./priv/static/js",
    filename: "[name].js"
  },

  devtool: "#source-map",

  resolve: {
    extensions: ['', '.js', '.elm', '.elmx'],
  },

  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-hot!elm-webpack',
      }, {
        test: /\.js$/,
        exclude:  [/elm-stuff/, /node_modules/],
        loader: 'babel',
      }, {
        test: /\.css$/,
        loader: 'style!css',
      }, {
        test: /.(png|woff(2)?|eot|ttf|svg|gif)(\?[a-z0-9=\.]+)?$/,
        loader: 'url?limit=100000',
      },
    ],
    noParse: [/.elm$/],
  },
};
