class Aries.Views.Feature extends Backbone.View
	template: HandlebarsTemplates['app/templates/feature']
	render: ->
		@$el.html(@template(@model.toJSON()))
		@