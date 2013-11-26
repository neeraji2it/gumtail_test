class Aries.Views.Empty extends Backbone.View
	className: ""

	render: ->
		@$el.html('<h3>MAin content here</h3>')
		@