React = require 'react'
window.jQuery = window.$ = require 'jquery'
MarkdownTextarea = require('./index')
marked = require 'marked'

# Assign react to Window so the Chrome React Dev Tools will work
window.React = React

CommentBox = React.createClass(
  getInitialState: ->
    comments: ['The first comment!']
    saving: false

  handleSave: (value) ->
    @setState saving: true
    setTimeout((=>
      @setState {
        comments: @state.comments.concat(value)
        saving: false
      }
    ), 500)

  render: ->
    comments = []
    for comment in @state.comments
      comments.push <li dangerouslySetInnerHTML={__html: marked(comment)} />

    return (
      <div>
        <h3>Comments</h3>
        <ul>{comments}</ul>
        <MarkdownTextarea saving={@state.saving} key={@state.comments.length} initialValue={@state.text} onSave={@handleSave} placeholder="Write new comment" />
      </div>
    )
)

React.renderComponent(
  <div>
    <h1>React Markdown Textarea</h1>
    <p>Auto-resizing, built-in preview awesomeness!</p>
    <h3>Install</h3>
    <code>npm install react-markdown-textarea</code>
    <br />

    <h3>Basic usage</h3>
    <pre><code>
      MarkdownTextarea = require('react-markdown-textarea');<br />
     {"React.renderComponent(<MarkdownTextarea />, document.body);"}
    </code></pre>

    <h3>Theming</h3>
    <p>The component ships with the minimum CSS to position the various elements
    correctly. You'll be expected to write additional CSS in order to make it fit
    your application. In the Git repository, there's a <a href="https://github.com/KyleAMathews/react-markdown-textarea/blob/master/src/styles/_react_markdown_textarea.scss">SCSS file</a> that's used
    on this page that you can use as a starting point. Class names follow the 
    <a href="http://bem.info/method/">BEM methodology</a> as can seen by inspecting
    the examples below e.g. <code>react-markdown-textarea__button</code>{" "}
     is the class name for the button.
    </p>

    <h3>Misc</h3>
    <a href="https://github.com/KyleAMathews/react-markdown-textarea">Github repository</a>
    <br />
    <a href="https://github.com/KyleAMathews/react-markdown-textarea/issues">Support</a>

    <hr />
    <h1>Examples</h1>
    <h2>No arguments</h2>
    <code>{"<MarkdownTextarea />"}</code>
    <br />
    <br />
    <MarkdownTextarea />
    <hr />

    <h2>Set the initial value</h2>
    <code>{"<MarkdownTextarea initialValue='Type some *markdown* here!' />"}</code>
    <br />
    <br />
    <MarkdownTextarea initialValue='Type some *markdown* here!' />
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

    <h2>Include a delete button</h2>
    <code>{"<MarkdownTextarea deleteButton=true onDelete={-> alert(\"I'm gone!!\")} />"}</code>
    <br />
    <br />
    <MarkdownTextarea deleteButton=true onDelete={-> alert("I'm gone!!")} />
    <hr />

    <h2>Disable preview</h2>
    <code>{"<MarkdownTextarea noPreview />"}</code>
    <br />
    <br />
    <MarkdownTextarea noPreview />
    <hr />

    <h2>Comment box example</h2>
    <pre><code>{"""
CommentBox = React.createClass(
  getInitialState: ->
    comments: ['The first comment!']
    saving: false

  handleSave: (value) ->
    @setState saving: true
    setTimeout((=>
      @setState {
        comments: @state.comments.concat(value)
        saving: false
      }
    ), 500)

  render: ->
    comments = []
    for comment in @state.comments
      comments.push <li dangerouslySetInnerHTML={__html: marked(comment)} />

    return (
      <div>
        <h3>Comments</h3>
        <ul>{comments}</ul>
        <MarkdownTextarea saving={@state.saving} initialValue={@state.text} onSave={@handleSave} placeholder="Write new comment" />
      </div>
    )
)
"""}</code></pre>
    <CommentBox />
    <hr />

    <h1>Thanks</h1>

    <p>This code is built on the great work of many other open-source contributers.</p>
    <ul>
      <li><a href="http://facebook.github.io/react/">React from Facebook</a></li>
      <li><a href="https://github.com/andreypopp/react-textarea-autosize">react-textarea-autosize</a> by <a href="https://github.com/andreypopp">Audrey Popp</a></li>
      <li><a href="https://github.com/jackmoore/autosize">jQuery plugin Autosize</a> by <a href="https://github.com/jackmoore">Jack Moore</a></li>
    </ul>


  </div>
  , document.body)
