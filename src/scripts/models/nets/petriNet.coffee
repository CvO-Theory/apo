class @PetriNet extends @Net
	constructor: (netObject) ->
		@type = "pn"
		super(netObject)
		@setTools([
			new PlaceTool()
			new TransitionTool()
			new ArrowTool()
			new TokenTool()
			new DeleteTool()
			new LabelPnTool()
		])

	addTransition: (point) ->
		transition = new Transition(point)
		@addNode(transition)

	addPlace: (point) ->
		place = new Place(point)
		@addNode(place)

	isFirable: (transition) ->
		return false if transition.type isnt "transition"
		preset = @getPreset(transition)
		return false for place in preset when place.token < 1
		return true

	getEdgeWeight: (source, target) ->
		for edge in @edges
			if edge.source.id is source.id and edge.target.id is target.id
				return edge.right
			else if edge.source.id is target.id and edge.target.id is source.id
				return edge.left
		return 0

	fireTransition: (transition) ->
		return false if not @isFirable(transition)
		preset = @getPreset(transition)
		postset = @getPostset(transition)
		for place in preset
			place.token = parseInt(place.token) - parseInt(@getEdgeWeight(place, transition))
		for place in postset
			place.token = parseInt(place.token) + parseInt(@getEdgeWeight(transition, place))
		return true
