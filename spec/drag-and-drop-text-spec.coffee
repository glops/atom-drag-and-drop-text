{WorkspaceView} = require 'atom'
DragAndDropText = require '../lib/drag-and-drop-text'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "DragAndDropText", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('drag-and-drop-text')

  describe "when the drag-and-drop-text:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.drag-and-drop-text')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'drag-and-drop-text:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.drag-and-drop-text')).toExist()
        atom.workspaceView.trigger 'drag-and-drop-text:toggle'
        expect(atom.workspaceView.find('.drag-and-drop-text')).not.toExist()
