class Aries.Views.Stories extends Backbone.View
	template: HandlebarsTemplates['app/templates/stories']

	initialize: ->
		@listenTo @collection, "reset", @render
		@collection.fetch({ reset: true })

	render: ->
		@$el.html(@template())
		@collection.forEach @renderStory, @
		@
	renderStory: (model) ->
		v = new Aries.Views.Story({ model: model })
		@$('ul').append(v.render().el)