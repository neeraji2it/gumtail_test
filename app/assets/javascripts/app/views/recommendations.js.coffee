class Aries.Views.Recommendations extends Backbone.View
	template: HandlebarsTemplates['app/templates/recommendations']

	initialize: ->
		@listenTo @collection, "reset", @render
		@collection.fetch({ reset: true })

	render: ->
		@$el.html(@template())
		@collection.forEach @renderRecommendation, @
		@
	renderRecommendation: (model) ->
		v = new Aries.Views.Recommendation({ model: model })
		@$('ul').append(v.render().el)