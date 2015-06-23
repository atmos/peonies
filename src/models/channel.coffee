Fs = require "fs"

ChannelElement = require "../react/channel"

class Channel
  constructor: (@team, @id) ->
    options =
      key: @id
      team: @team
      parent: @app

    @messages = [ ]
    @reactElement = new React.createElement ChannelElement, options

  name: () ->
    @team.name()

  userFor: (name) ->
    @team.connection.client.users[name]

  addMessage: () ->

module.exports = Channel
