React = require 'react'
window.jQuery = window.$ = require 'jquery'
MarkdownTextarea = require('./index')

# Assign react to Window so the Chrome React Dev Tools will work
window.React = React

React.renderComponent(
  <div>
    <h2>Default</h2>
    <code>{"<MarkdownTextarea />"}</code>
    <br />
    <br />
    <MarkdownTextarea />
    <hr />

    <h2>Pass attributes to the textarea element</h2>
    <code>{"<MarkdownTextarea rows=4 />"}</code>
    <br />
    <br />
    <MarkdownTextarea rows=4 />
    <hr />

    <h2>Placeholder</h2>
    <code>{"<MarkdownTextarea placeholder='A cool placeholder' />"}</code>
    <br />
    <br />
    <MarkdownTextarea placeholder='A cool placeholder' />
  </div>
  , document.body)
