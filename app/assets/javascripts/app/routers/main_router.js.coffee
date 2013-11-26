class Aries.Routers.MainRouter extends Backbone.Router
	routes:
		"":"index"
		"home/stories": "homeStories"
		"home/subscriptions": "homeSubscriptions"
		"home/recommendations": "homeRecommendations"
		"tests/:id": "show"

	initialize: ->
      	@contentView = new Aries.Views.Content()

	index: ->
		@layoutViews()
		@contentView.swapMain(new Aries.Views.Features({ collection: new Aries.Collections.Features }))

	homeStories: ->
		@layoutViews()
		@contentView.swapMain(new Aries.Views.Stories({ collection: new Aries.Collections.Stories }))

	homeSubscriptions: ->
		@layoutViews()
		@contentView.swapMain(new Aries.Views.Subscriptions({ collection: new Aries.Collections.Subscriptions }))

	homeRecommendations: ->
		@layoutViews()
		@contentView.swapMain(new Aries.Views.Recommendations({ collection: new Aries.Collections.Recommendations }))


	show: (id) ->
		alert("Testing #{id}")


	layoutViews: ->
		$('#content').html(@contentView.render().el)

	

