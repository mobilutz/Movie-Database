class Imdb.Views.MovieIndex extends Backbone.View
  template: JST['movies/movie']
  tagName: 'tr'

  events:
    'click': 'showMovie'

  showMovie: (movie) ->
    window.location = "/movies/#{@model.get('id')}"

  render: ->
    $(@el).html(@template(movie: @model.toJSON()))
    @
