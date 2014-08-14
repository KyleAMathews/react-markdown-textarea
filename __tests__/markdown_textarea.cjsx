# @cjsx React.DOM

jest.dontMock '../src/index'

describe 'markdownTextarea', ->
  it 'should render a textarea', ->
    React = require 'react/addons'
    MarkdownTextarea = require '../src/index'
    TestUtils = React.addons.TestUtils

    # Render the MarkdownTextarea component.
    markdownTextarea = <MarkdownTextarea />
    TestUtils.renderIntoDocument(markdownTextarea)

    # Verify the textearea element was created.
    textarea = TestUtils.findRenderedDOMComponentWithTag(markdownTextarea, 'textarea')
    expect(textarea).toBeDefined()

  it 'should take an initial value for the markdown', ->
    React = require 'react/addons'
    MarkdownTextarea = require '../src/index'
    TestUtils = React.addons.TestUtils

    # Render the MarkdownTextarea component.
    markdownTextarea = <MarkdownTextarea initialValue='type some *markdown* here!' />
    TestUtils.renderIntoDocument(markdownTextarea)

    # Verify the textearea element was created.
    textarea = TestUtils.findRenderedDOMComponentWithTag(markdownTextarea, 'textarea')
    expect(textarea.getDOMNode().value).toEqual('type some *markdown* here!')

  it 'should call a provided onSave function when the save button is clicked', ->
    React = require 'react/addons'
    MarkdownTextarea = require '../src/index'
    TestUtils = React.addons.TestUtils

    # Render the MarkdownTextarea component.
    onSave = jest.genMockFunction()
    markdownTextarea = <MarkdownTextarea onSave={onSave} />
    TestUtils.renderIntoDocument(markdownTextarea)

    # Simulate clicking the markdown button and verify our onSave function was called.
    button = TestUtils.findRenderedDOMComponentWithTag(markdownTextarea, 'button')
    TestUtils.Simulate.click(button)

    expect(onSave).toBeCalled()

  it 'should call a provided onDelete function when the delete button is clicked', ->
    React = require 'react/addons'
    MarkdownTextarea = require '../src/index'
    TestUtils = React.addons.TestUtils

    # Render the MarkdownTextarea component.
    onDelete = jest.genMockFunction()
    markdownTextarea = <MarkdownTextarea deleteButton=true onDelete={onDelete} />
    TestUtils.renderIntoDocument(markdownTextarea)

    # Simulate clicking the markdown button and verify our onSave function was called.
    button = TestUtils.findRenderedDOMComponentWithClass(markdownTextarea, 'react-markdown-textarea__delete-button')
    TestUtils.Simulate.click(button)

    expect(onDelete).toBeCalled()

  it 'should remove the write/preview tabs if noPreview is passed in', ->
    React = require 'react/addons'
    MarkdownTextarea = require '../src/index'
    TestUtils = React.addons.TestUtils

    # Render the MarkdownTextarea component.
    markdownTextarea = <MarkdownTextarea noPreview />
    TestUtils.renderIntoDocument(markdownTextarea)

    results = TestUtils.scryRenderedDOMComponentsWithClass(markdownTextarea, 'react-markdown-textarea__nav')

    expect(results.length).toEqual(0)
