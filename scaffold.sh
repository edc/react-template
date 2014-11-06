mkdir src
echo "alert 1" > src/init.coffee

mkdir assets
cat << EOF > assets/index.html
<!DOCTYPE html>
<html lang="en">
<body>
<h1>Welcome</h1>
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="js/bundle.js"></script>
</body>
</html>
EOF

npm init

npm install webpack webpack-dev-server coffee-loader jsx-loader --save-dev
npm install backbone jquery react --save-dev

cat << EOF > webpack.config.js
module.exports = {
    context: __dirname + "/src",
    entry: "./init.coffee",
    output: {
        path: __dirname + "build",
        filename: "js/bundle.js"
    },
    module: {
        loaders: [
            { test: /\.coffee$/, loader: "coffee-loader" },
            { test: /\.jsx$/, loader: "jsx-loader" }
        ]
    },
    externals: {
        jquery: 'jQuery'
    },
    devServer: {
        contentBase: "./assets",
    }
};
EOF


cat << EOF > src/greet.jsx
module.exports = function() {
  return <div>Hello {this.props.name}</div>
}
EOF

cat << EOF >> src/init.coffee

React = window.React = require('react')

GreetBox = React.createClass
  render: -> require('./greet.jsx').call(this)

React.render React.createElement(GreetBox, {name: "Joe"}),
  document.getElementsByTagName('h1')[0]
EOF
