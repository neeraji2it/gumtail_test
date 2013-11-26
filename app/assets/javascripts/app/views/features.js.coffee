class Aries.Views.Features extends Backbone.View
	template: HandlebarsTemplates['app/templates/features']

	initialize: ->
		@listenTo @collection, "reset", @render
		@collection.fetch({ reset: true })

	render: ->
		@$el.html(@template())
		@collection.forEach @renderFeature, @
		@
	renderFeature: (model) ->
		v = new Aries.Views.Feature({ model: model })
		@$('ul').append(v.render().el)