React = require 'react'
window.jQuery = window.$ = require 'jquery'
MarkdownTextarea = require('./index')

# Assign react to Window so the Chrome React Dev Tools will work
window.React = React

React.renderComponent(
  <div>
    <h1>React Markdown Textarea</h1>
    <p>Auto-resizing, built-in preview awesomeness!</p>
    <h3>Install</h3>
    <code>npm install react-markdown-textarea</code>
    <br />

    <h3>Basic usage</h3>
    <pre><code>
      MarkdownTextarea = require('react-markdown-textarea');
      React.renderComponent(MarkdownTextarea, document.body);
    </code></pre>

    <h3>CSS</h3>
    <p>The component ships with the minimum CSS to position the various elements
    correctly. You'll be expected to write additional CSS in order to make it fit
    your application. In the Git repository, there's a <a href="https://github.com/KyleAMathews/react-markdown-textarea/blob/master/src/styles/_react_markdown_textarea.scss">SCSS file</a> that's used
    on this page that you can use as a starting point. Class names follow the 
    <a href="http://bem.info/method/">BEM methodology</a> as can seen by inspecting
    the examples below e.g. <code>react-markdown-textarea__textarea-wrapper__button </code>
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
