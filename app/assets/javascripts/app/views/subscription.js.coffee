class Aries.Views.Subscription extends Backbone.View
	template: HandlebarsTemplates['app/templates/subscription']
	render: ->
		@$el.html(@template(@model.toJSON()))
		@