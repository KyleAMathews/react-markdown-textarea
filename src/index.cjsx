React = require 'react/addons'
Textarea = require('react-textarea-autosize')
marked = require 'marked'

module.exports = React.createClass
  displayName: 'MarkdownTextarea'

  getDefaultProps: ->
    buttonText: "Save"
    onSave: (value) ->
    onDelete: ->
    onChange: (value) ->
    deleteButton: false
    spinnerOptions: {}

  getInitialState: ->
    state = {
      active: 'write'
      value: if @props.initialValue? then @props.initialValue else ""
    }

    return state

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
      display: 'block'
      resize: 'none'
    }

    # Are we writing or previewing?
    #
    # Swap between writing and previewing states.
    if @state.active is 'write'
      textarea = @transferPropsTo(<Textarea
        className="react-markdown-textarea__textarea"
        value={@state.value}
        onChange={@handleChange}
        ref="textarea"
        style={textareaStyles}
       />)
    else
      textarea = <div
          className="react-markdown-textarea__preview"
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
          <button
            onClick={@_onSave}
            disabled={if @props.saving then "disabled" else false}
            className="react-markdown-textarea__save-button">
              {@props.buttonText}
          </button>
          { if @props.deleteButton
            <button
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
    newValue = @refs.textarea.getDOMNode().value
    @setState value: newValue
    @props.onChange(newValue)

  _onSave: ->
    @props.onSave(@state.value)

  _onDelete: ->
    @props.onDelete()
