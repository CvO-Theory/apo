class @MoveTool extends @Tool
	constructor: ->
		super()
		@name = "Fix Nodes"
		@icon = "gps_fixed"
		@draggable = true

	mouseDownOnNode: (net, node) ->
		node.fixed = true

	dblClickOnNode: (net, node) ->
		node.fixed = false
