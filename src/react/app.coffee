App = React.createClass
  render: ->
    <div className="chat">
      <ul id="teams-list">{@props.connections}</ul>
    </div>

module.exports = App

kyle =
  name: "kneath"
  profile:
    image_192: "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2014-03-26/2246175298_192.jpg"

atmos =
  name: "atmos"
  profile:
    image_192: "https://secure.gravatar.com/avatar/a86224d72ce21cd9f5bee6784d4b06c7.jpg?s=192&d=https%3A%2F%2Fslack.global.ssl.fastly.net%2F3654%2Fimg%2Favatars%2Fava_0010.png"

chat =
  general:
    [
      {
        id: 111111
        user: kyle
        msg:
          txt: "That's fucking ridiculous and the stupidest thing I've ever heard"
      },
      {
        id: 69696969
        user: atmos
        msg:
          txt: "But it is true"
      },
      {
        id: 62149496
        user: kyle
        msg:
          txt: "That's just because you're high"
      }
    ]

  beats:
    [
      {
        id: 111111
        user: kyle
        msg:
          txt: "TRAP FEVER"
      },
      {
        id: 69696969
        user: atmos
        msg:
          txt: "Bass is best"
      }
    ]

  bullshit:
    [
      {
        id: 111111
        user: kyle
        msg:
          txt: "Bully sticks are made of bull penis"
      },
      {
        id: 69696969
        user: atmos
        msg:
          txt: "Bullshit"
      }
    ]


FakeApp = React.createClass
  getInitialState: ->
    return {
      channels: [
        { name: "#general" },
        { name: "#beats" },
        { name: "#bullshit" }
      ]

      activeChannel: "#general"

      messages: chat["general"]
    }

  handleChangeChannel: (channel) ->
    this.setState({ activeChannel: channel, messages: chat[channel.substring(1)] })

  render: ->
    <div className="chat">
      <div className="teams-sidebar">
      </div>
      <div className="team">
        <ChannelList channels={ @state.channels } active={ @state.activeChannel } onChange={ this.handleChangeChannel } />
        <MessageList messages={ @state.messages } />
      </div>
    </div>

module.exports = FakeApp

renderFakeApp = () ->
  React.render <FakeApp />, document.getElementById("fake-chat-app")

setTimeout(renderFakeApp, 100)


ChannelList = React.createClass
  handleChange: (channelName) ->
    @props.onChange(channelName)

  render: ->
    return null if @props.channels == undefined || @props.channels.length == 0
    component = this
    <ul className="channels">
      { @props.channels.map (channel) ->
        klass = ""
        klass += "active" if component.props.active == channel.name
        <li key={ channel.name } onClick={ component.handleChange.bind(component, channel.name ) } className={ klass }>{ channel.name }</li>
      }
    </ul>

module.exports = ChannelList


MessageList = React.createClass
  render: ->
    return null if @props.messages == undefined || @props.messages.length == 0
    <div className="messages">
      { @props.messages.map (message) ->
        <div key={ message.id } className="message">
          <span className="avatar">
            <img src={ message.user.profile.image_192 } />
          </span>
          <h4 className="author">{ message.user.name }</h4>
          <div className="content text">{ message.msg.txt }</div>
        </div>
      }
    </div>

module.exports = MessageList
