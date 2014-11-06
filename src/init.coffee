alert "OK"

React = window.React = require('react')

GreetBox = React.createClass
  render: require('./greet.jsx')

React.render React.createElement(GreetBox, {name: "Joe"}),
  document.getElementsByTagName('h1')[0]
