class Aries.Views.Story extends Backbone.View
	template: HandlebarsTemplates['app/templates/story']
	render: ->
		@$el.html(@template(@model.toJSON()))
		@