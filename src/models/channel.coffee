Message        = require "./message"
Attachment     = require "./attachment"

class Channel
  constructor: (@team, @id) ->
    options =
      key: @id
      parent: @team

    @messages = [ ]

  teamName: () ->
    @team.name()

  userFor: (name) ->
    @team.connection.client.users[name]

  reactMessages: () ->
    (message.reactElement for message in @messages)

  appendMessageOrAttachment: (obj) ->
    @messages.shift() if @messages.length > 250
    @messages.push(obj)

  addMessage: (msg) ->
    if @userFor(msg.user)
      message = new Message(@, msg)
      @appendMessageOrAttachment(message)

    if msg.attachments?
      console.log "#{msg.attachments.length} attachments fffffound!"
      for msgObject, index in msg.attachments
        attachment = new Attachment(msg, msgObject, index)
        @appendMessageOrAttachment(attachment)

module.exports = Channel
