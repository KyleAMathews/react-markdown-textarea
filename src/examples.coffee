React = require 'react'
window.jQuery = window.$ = require 'jquery'
MarkdownTextarea = require('./index')

# Assign react to Window so the Chrome React Dev Tools will work
window.React = React

React.renderComponent(
  <div>
    <h1>React Markdown Textarea</h1>
    <p>Auto-resizing, built-in preview awesomeness!</p>
    <code>npm install react-markdown-textarea</code>
    <br />
    <br />
    <br />

    <h2>No arguments</h2>
    <code>{"<MarkdownTextarea />"}</code>
    <br />
    <br />
    <MarkdownTextarea />
    <hr />

    <h2>Set a default value</h2>
    <code>{"<MarkdownTextarea value='Type some *markdown* here!' />"}</code>
    <br />
    <br />
    <MarkdownTextarea value='Type some *markdown* here!' />
    <hr />

    <h2>Pass attributes to the textarea element</h2>
    <code>{"<MarkdownTextarea rows=6 />"}</code>
    <br />
    <br />
    <MarkdownTextarea rows=6 />
    <hr />

    <h2>Placeholder</h2>
    <code>{"<MarkdownTextarea placeholder='A cool placeholder' />"}</code>
    <br />
    <br />
    <MarkdownTextarea placeholder='A cool placeholder' />
    <hr />

    <h2>Override the button text</h2>
    <code>{"<MarkdownTextarea buttonText='Save new comment' />"}</code>
    <br />
    <br />
    <MarkdownTextarea buttonText="Save new comment" />
    <hr />

    <h2>Disable preview</h2>
    <code>{"<MarkdownTextarea noPreview />"}</code>
    <br />
    <br />
    <MarkdownTextarea noPreview />
  </div>
  , document.body)
