class Imdb.Models.Movie extends Backbone.Model
  removeEverything: ->
    xhr = @destroy
      wait: true
    if xhr.status == 204
      @removeFromCollection(null, null, null)

  removeFromCollection: (model, response, options) ->
    console.info 'removeFromCollection'

  errorHandler: (model, xhr, options) ->
    console.info 'errorHandler'
