Skeleton with Webpack, CoffeeScript, Backbone and React
--------------------------------------------------------

### How is this created

(All commmands listed below are captured in `scaffold.sh`.)

1. Make the folders and empty files

  ```
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
```

2. Initialize this as an NPM package, interactively via

  ```
npm init
```

3. Install all dependencies:

  ```
npm install webpack webpack-dev-server coffee-loader jsx-loader --save-dev
npm install backbone react --save-dev
```

  Note that we can install regular application dependencies like react via npm!
No need for bower.

  Also note that we use jquery from a CDN, and take advantage of webpack's
"external" feature.

4. Create the webpack config:

  ```javascript
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
```

  Note that `filename` actually has a folder in it. This is important because
the filename is the one exposed by webpack-dev-server. So it's best to keep
this consistent with the actual name used in script tag.

5. Create some react code

  ```javascript
cat << EOF > src/greet.jsx
module.exports = function() { return (

<div>Hello {this.props.name}</div>


)}
EOF

cat << EOF >> src/init.coffee

React = window.React = require('react')

GreetBox = React.createClass
  render: require('./greet.jsx')

React.render React.createElement(GreetBox, {name: "Joe"}),
  document.getElementsByTagName('h1')[0]
EOF
```
