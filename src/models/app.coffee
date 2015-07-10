Team            = require "./team"
Config          = require "../config"
AppElement      = require "../react/app"
MessageElement  = require "../react/message"
SlackConnection = require "../slack_connection"

class App
  constructor: (@document) ->
    tokenFile = "#{process.env.HOME}/.electrogram.json"
    @config = new Config tokenFile
    @connections = { }
    @reactElement = React.createElement AppElement, {key: "global", parent: @ }

  setup: () ->
    for token in @config.tokens
      @addConnection(new SlackConnection(token))

  teamForName: (name) ->
    team = (team for teamId, team of @connections when team.name() is name)
    if team? then team[0] else null

  addConnection: (connection) ->
    connection.on "login", (conn, user, team) =>
      team = new Team(@, conn, user, team)
      @connections[user.id] = team

      for preferredChannel in @config.channels
        [teamName, channelName] = preferredChannel.name.split("#")
        if teamName is team.team.name
          for channelId, channel of conn.client.channels
            if channelName is channel.name
              channel.fetchHistory()

      setTimeout ( =>
        connection.client.autoMark = true
      ), 5000


    connection.on "message", (conn, msg) =>
      team = @teamForName(msg._client.team.name)

      channel = team.channelForNameOrId(msg.channel, msg.channel)
      if channel?
        channel.addMessage(msg)

module.exports = App
