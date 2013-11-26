class Aries.Views.Tags extends Backbone.View
	template: HandlebarsTemplates['app/templates/tags']

	initialize: ->
		@listenTo @collection, "reset", @render
		@collection.fetch({ reset: true })

	render: ->
		@$el.html(@template())
		@collection.forEach @renderTag, @
		@
	renderTag: (model) ->
		v = new Aries.Views.Tag({ model: model })
		@$('ul').append(v.render().el)