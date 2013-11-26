class Aries.Views.Subscriptions extends Backbone.View
	template: HandlebarsTemplates['app/templates/subscriptions']

	initialize: ->
		@listenTo @collection, "reset", @render
		@collection.fetch({ reset: true })

	render: ->
		@$el.html(@template())
		@collection.forEach @renderSubscription, @
		@
	renderSubscription: (model) ->
		v = new Aries.Views.Subscription({ model: model })
		@$('ul').append(v.render().el)