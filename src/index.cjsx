React = require 'react/addons'
Textarea = require('react-textarea-autosize')
marked = require 'marked'
classNames = require 'classnames'
objectAssign = require 'object-assign'

module.exports = React.createClass
  displayName: 'MarkdownTextarea'

  getDefaultProps: ->
    buttonText: "Save"
    onSave: (value) ->
    onDelete: ->
    onChange: (value) ->
    deleteButton: false
    spinnerOptions: {}
    navTabStyle: {}
    tabStyle: {
      cursor: 'pointer'
      display: 'inline-block'
      listStyle: 'none'
    }
    textareaWrapperStyle: {}
    tabActiveStyle: {}
    textareaStyle: {
      display: 'block'
      resize: 'none'
    }
    previewStyle: {}
    buttonStyle: {}
    deleteButtonStyle: {}

  getInitialState: ->
    state = {
      active: 'write'
      value: if @props.initialValue? then @props.initialValue else ""
    }

    return state

  render: ->
    # Class names
    writeTabClasses = classNames({
      'react-markdown-textarea__nav__item': true
      'react-markdown-textarea__nav__item--active': @state.active is "write"
    })
    previewTabClasses = classNames({
      'react-markdown-textarea__nav__item': true
      'react-markdown-textarea__nav__item--active': @state.active is "preview"
    })

    # Tabs style
    if @state.active is "write"
      writeStyle = objectAssign {}, @props.tabStyle, @props.tabActiveStyle
      previewStyle = @props.tabStyle
    else if @state.active is "preview"
      writeStyle = @props.tabStyle
      previewStyle = objectAssign {}, @props.tabStyle, @props.tabActiveStyle

    # Are we writing or previewing?
    #
    # Swap between writing and previewing states.
    if @state.active is 'write'
      textarea = <Textarea
        {...@props}
        className="react-markdown-textarea__textarea"
        value={@state.value}
        onChange={@handleChange}
        ref="textarea"
        style={@props.textareaStyle}
       />
    else
      textarea = <div
          className="react-markdown-textarea__preview"
          style={@props.previewStyle}
          dangerouslySetInnerHTML={__html: marked(@state.value)}>
      </div>

    # Add preview?
    unless @props.noPreview
      tabs =
        <ul className="react-markdown-textarea__nav" onMouseDown={@toggleTab} style={@props.navTabStyle}>
          <li className={writeTabClasses} style={writeStyle}>Write</li>
          <li className={previewTabClasses} style={previewStyle}>Preview</li>
        </ul>

    return (
      <div className="react-markdown-textarea">
        {tabs}
        <div
          className="react-markdown-textarea__textarea-wrapper"
          style={@props.textareaWrapperStyle}
        >
          {textarea}
          <button
            onClick={@_onSave}
            style={@props.buttonStyle}
            disabled={if @props.saving then "disabled" else false}
            className="react-markdown-textarea__save-button">
              {@props.buttonText}
          </button>
          { if @props.deleteButton
            <button
              style={@props.deleteButtonStyle}
              onClick={@_onDelete}
              disabled={if @props.saving then "disabled" else false}
              className="react-markdown-textarea__delete-button">
                Delete
            </button>
          }
          {if @props.saving and @props.spinner?
            @props.spinner(@props.spinnerOptions)
          }
        </div>
      </div>
    )

  toggleTab: (e) ->
    # Ignore clicks not on an li
    unless e.target.tagName is "LI" then return
    # Ignore clicks on the active tab.
    if "react-markdown-textarea__nav__item--active" in e.target.className.split(/\s+/)
      return

    if @state.active is "write"
      @setState active: 'preview'
    else
      @setState active: 'write'

  handleChange: (e) ->
    @setState value: e.target.value
    @props.onChange(e.target.value)

  _onSave: ->
    @props.onSave(@state.value)

  _onDelete: ->
    @props.onDelete()
