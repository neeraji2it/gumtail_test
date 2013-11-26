class Aries.Views.Recommendation extends Backbone.View
	template: HandlebarsTemplates['app/templates/recommendation']
	render: ->
		@$el.html(@template(@model.toJSON()))
		@