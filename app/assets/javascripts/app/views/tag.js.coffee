class Aries.Views.Tag extends Backbone.View
	template: HandlebarsTemplates['app/templates/tag']
	render: ->
		@$el.html(@template(@model.toJSON()))
		@