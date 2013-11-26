class Aries.Models.BackboneInfo extends Backbone.Model

  initialize: ->
    @listenTo Aries.Vent, "user:logged_in", @login
    @listenTo Aries.Vent, "user:logged_out", @logout

  login: (id, username) ->
    @set id: id, username: username, loggedIn: true, current_page: current_page

  logout: ->
    m = new Aries.Models.Login({ id: @id })
    m.destroy
      success: (model, data) =>
        @set loggedIn: false
        delete @id
        delete @attributes.username
        delete @attributes.id
        window.csrf(data.csrf)