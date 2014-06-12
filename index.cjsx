React = require 'react'
window.jQuery = window.$ = require 'jquery'
Textarea = require('react-textarea-autosize')

module.exports = React.createClass
  render: ->
    textarea = @transferPropsTo(<Textarea autosize />)
    return (
      <div>
        {textarea}
      </div>
    )
