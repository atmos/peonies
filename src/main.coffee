require "coffee-react/register"

App = require "./models/app"

app = new App(document)
app.setup()

setTimeout ( ->
  React.render app.reactElement, document.getElementById("chat-app")
), 100
