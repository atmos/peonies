Channel = React.createClass
  render: ->
    <div className="channel">
      <span className="channel-name">{@props.name}</span>
      <ul id="messages-list" className="messages">{@props.messages}</ul>
    </div>

module.exports = Channel
