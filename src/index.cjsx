React = require 'react/addons'
window.jQuery = window.$ = require 'jquery'
Textarea = require('react-textarea-autosize')
marked = require 'marked'

module.exports = React.createClass
  displayName: 'MarkdownTextarea'
  getInitialState: ->
    state = {
      active: 'write'
      value: ''
    }

    return state

  getDefaultProps: ->
    buttonText: "Save"
    onSave: (value) ->
    onChange: (value) ->

  # On mounting and when props are changed, copy props over to value.
  # we if we click preview, we immediately have something to preview.
  componentDidMount: ->
    if @props.value?
      @setState value: @props.value
    else if @props.defaultValue?
      @setState value: @props.defaultValue

  componentWillReceiveProps: (nextProps) ->
    if nextProps.value?
      @setState value: nextProps.value
    else if nextProps.defaultValue?
      @setState value: nextProps.defaultValue

  toggleTab: (e) ->
    # Ignore clicks not on an li
    unless e.target.tagName is "LI" then return
    # Ignore clicks on the active tab.
    if e.target.className is "react-markdown-textarea__nav__item--active" then return

    if @state.active is "write"
      @setState active: 'preview'
    else
      @setState active: 'write'

  handleChange: (e) ->
    newValue = @refs.textarea.getDOMNode().value
    @setState value: newValue
    @props.onChange(newValue)

  _onSave: ->
    @props.onSave(@state.value)

  render: ->
    # Class names
    cx = React.addons.classSet
    writeTabClasses = cx({
      'react-markdown-textarea__nav__item': true
      'react-markdown-textarea__nav__item--active': @state.active is "write"
    })
    previewTabClasses = cx({
      'react-markdown-textarea__nav__item': true
      'react-markdown-textarea__nav__item--active': @state.active is "preview"
    })

    ulStyles = {
      display: 'inline-block'
    }
    liStyles = {
      listStyle: 'none'
      float: 'left'
      cursor: 'pointer'
    }
    textareaStyles = {
      border: 'none'
      display: 'block'
      resize: 'none'
    }

    # Are we writing or previewing.
    if @state.active is 'write'
      textarea = @transferPropsTo(<Textarea
        className="react-markdown-textarea__textarea"
        autosize
        onChange={@handleChange}
        ref="textarea"
        style={textareaStyles}
       />)
      saveButton = <button onClick={@_onSave} className="react-markdown-textarea__save-button">{@props.buttonText}</button>
    else
      textarea = <div
          className="react-markdown-textarea__preview"
          style={padding: '6.5px'}
          dangerouslySetInnerHTML={__html: marked(@state.value)}>
      </div>

    # Add preview?
    unless @props.noPreview
      tabs =
        <ul className="react-markdown-textarea__nav" onMouseDown={@toggleTab} style={ulStyles}>
          <li className={writeTabClasses} style={liStyles}>Write</li>
          <li className={previewTabClasses} style={liStyles}>Preview</li>
        </ul>

    return (
      <div className="react-markdown-textarea">
        {tabs}
        <div className="react-markdown-textarea__textarea-wrapper">
          {textarea}
          {saveButton}
        </div>
      </div>
    )
