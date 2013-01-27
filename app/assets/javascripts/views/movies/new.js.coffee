class Imdb.Views.MovieNew extends Backbone.View
  template: JST['movies/new']

  events:
    'click #submit' : 'createMovie'
    'click #cancel' : 'returnToIndex'

  createMovie: (event) ->
    event.preventDefault()
    # console.info "newMovie"
    $('.help-inline').remove()
    attributes =
      title: $('#title').val()
      text: $('#text').val()
      category:
        id: $('#category').val()
    @collection.create attributes,
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: (movie, response) =>
    # TODO - Problem with insertion and page reload. Somehow the new movie is not in the list in the right place, only after completet reload in browser
    @collection.fetch()
    Backbone.history.navigate('/')
    window.location.reload()

  handleError: (movie, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        $controlGroup = $("##{attribute}").first().parents('.control-group').first()
        $controlGroup.addClass('error')
        $controlGroup.find('.controls').append("<span class=\"help-inline\">#{message}</span>") for message in messages

  returnToIndex: (event) ->
    event.preventDefault()
    @collection.fetch()
    @return()

  return: ->
    Backbone.history.navigate('/', true)

  render: ->
    $(@el).html(@template(categories: gon.categories))
    @
