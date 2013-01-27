window.Imdb =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    if gon?
      new Imdb.Routers.Movies({movies: gon.movies})
      Backbone.history.start()

$(document).ready ->
  Imdb.initialize()
