React = require 'react'
window.jQuery = window.$ = require 'jquery'
MarkdownTextarea = require('./index')

# Assign react to Window so the Chrome React Dev Tools will work
window.React = React

React.renderComponent(
  <div>
    <h1>React Markdown Textarea</h1>
    <p>Autoexpanding, built-in preview awesomeness!</p>
    <code>npm install --save react-markdown-textarea</code>
    <br />
    <br />
    <br />

    <h2>No arguments</h2>
    <code>{"<MarkdownTextarea />"}</code>
    <br />
    <br />
    <MarkdownTextarea />
    <hr />

    <h2>Set the default value</h2>
    <code>{"<MarkdownTextarea value='Type some *markdown* here!' />"}</code>
    <br />
    <br />
    <MarkdownTextarea value='Type some *markdown* here!' />
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
