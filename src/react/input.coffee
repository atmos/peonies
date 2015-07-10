Input = React.createClass
  getInitialState: ->
    return { value: "" }

  handleChange: (event) ->
    @setState({ value: event.target.value })

  channelForKey: (key) ->
    [teamName, channelName] = key.split "#"

    if @props.application?
      team = @props.application.props.parent.teamForName(teamName)
      if team?
        for channelId, info of team.apiChannels()
          if channelName == info.name
            return team.apiChannels()[channelId]
    return null

  handleSubmit: (event) ->
    event.preventDefault()
    channel = @channelForKey(@props.application.state.activeChannel)
    console.log "YASSS: #{@state.value}"
    message = channel.send(@state.value)
    setTimeout ( =>
      console.log message.ts
      console.log message.user
      channel.addMessage(message)
    ), 300
    @setState(value: "")

  render: ->
    <form className="message-input-form" onSubmit={@handleSubmit}>
      <input type="text" value={@state.value} onChange={@handleChange} placeholder="Write something…" className="message-input" />
    </form>

module.exports = Input
