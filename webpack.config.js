module.exports = {
    context: __dirname + "/src",
    entry: "./init.coffee",
    output: {
        path: __dirname + "/build",
        filename: "js/bundle.js"
    },
    module: {
        loaders: [
            { test: /\.coffee$/, loader: "coffee-loader" },
            { test: /\.jsx$/, loader: "jsx-loader" }
        ]
    },
    devServer: {
        contentBase: "./assets",
    },
    externals: {
        jquery: 'jQuery'
    },
};
