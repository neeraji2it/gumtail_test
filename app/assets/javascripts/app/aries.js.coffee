#= require_self
#= require_tree ./models
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

window.Aries =
    Routers: {}
    Models: {}
    Views: {}
    Collections: {}
    Vent: _.clone(Backbone.Events)
    init: (data)-> 
    	Aries.backbone_info = new Aries.Models.BackboneInfo(data.backbone_info) 
    	new Aries.Routers.MainRouter()
    	Backbone.history.start()