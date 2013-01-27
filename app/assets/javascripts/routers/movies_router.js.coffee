class Imdb.Routers.Movies extends Backbone.Router
  routes:
    '' : 'index'
    'new' : 'newMovie'
    'movies' : 'index'
    'movies?:query' : 'index'
    '.*' : 'index'

  initialize: (options) ->
    @collection = new Imdb.Collections.Movies(total: gon.total)
    @collection.reset options.movies

  index: ->
    view = new Imdb.Views.MoviesIndex(collection: @collection)
    $('#container').html(view.render().el)

  newMovie: ->
    if current_user
      view = new Imdb.Views.MovieNew(collection: @collection)
      $('#container').html(view.render().el)
    else
      Backbone.history.navigate('#', true)
