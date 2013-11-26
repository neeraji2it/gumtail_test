class Aries.Views.Content extends Backbone.View
	className: "row"

	template: HandlebarsTemplates['app/templates/content']

	events: 
		"click a.homeStories": "homeStories"
		"click a.homeSubscriptions": "homeSubscriptions"
		"click a.homeRecommendations": "homeRecommendations"
		"click a.homeFeatured": "homeFeatured"

	homeFeatured: (e) ->
		e.preventDefault()
		@swapMain(new Aries.Views.Features({ collection: new Aries.Collections.Features }))
		Backbone.history.navigate ""

	homeStories: (e) ->
		e.preventDefault()
		@swapMain(new Aries.Views.Stories({ collection: new Aries.Collections.Stories }))
		Backbone.history.navigate "/home/stories"

	homeSubscriptions: (e) ->
		e.preventDefault()
		@swapMain(new Aries.Views.Subscriptions({ collection: new Aries.Collections.Subscriptions }))
		Backbone.history.navigate "/home/subscriptions"

	homeRecommendations: (e) ->
		e.preventDefault()
		@swapMain(new Aries.Views.Recommendations({ collection: new Aries.Collections.Recommendations }))
		Backbone.history.navigate "home/recommendations"

	render: ->
		@$el.html(@template())
		@renderSideView()
		@


	swapMain: (v) ->
		@changeCurrentMainView(v)
		@$('#main-area').html(@currentMainView.render().el)

	changeCurrentMainView: (v) ->
		@currentMainView.remove() if @currentMainView
		@currentMainView = v

	renderSideView: ->
		v = new Aries.Views.Tags({ collection: new Aries.Collections.Tags })
		@$('#side-bar').html(v.render().el)