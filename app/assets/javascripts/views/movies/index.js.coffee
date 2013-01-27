class Imdb.Views.MoviesIndex extends Backbone.View
  template: JST['movies/index']

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @appendMovie, @)
    @collection.on('destroy', @resetCollection, @)

  events:
    'submit #search_form': 'searchMovies'
    'click #ratings li': 'ratingFacet'
    'click #categories li' : 'categoryFacet'
    'click .next_page' : 'nextPage'
    'click .prev_page' : 'prevPage'
    'click .remove_rating' : 'removeRatingFacet'
    'click .remove_category' : 'removeCategoryFacet'

  searchMovies: (event) ->
    event.preventDefault()
    query = $('#search_field').val()
    @collection.ratingFacet = null
    @collection.categoryFacet = null
    @collection.page  = 1
    @collection.fetch({data: $.param({query: query})})

  ratingFacet: (event) ->
    event.preventDefault()
    @collection.categoryFacet = null
    @collection.ratingFacet = $(event.target).data('rating')
    @collection.fetch()

  categoryFacet: (event) ->
    event.preventDefault()
    @collection.ratingFacet = null
    @collection.categoryFacet = $(event.target).data('category')
    @collection.fetch()

  resetCollection: ->
    @collection.fetch()
    @render()

  nextPage: (event) ->
    event.preventDefault()
    if @collection.nextPage()
      @$('#movies').empty()
      @collection.each(@appendMovie, @)
      @pagination()

  prevPage: (event) ->
    event.preventDefault()
    if @collection.previousPage()
      @$('#movies').empty()
      @collection.each(@appendMovie, @)
      @pagination()

  render: ->
    $(@el).html(@template())
    if @collection.size() == 0
      @noData()
    else
      @collection.each(@appendMovie, @)
      @pagination()
    if gon?
      if gon.ratings?
        for rating in [0..5]
          @renderFacet(gon.ratings, 'ratings', 'rating', rating, "#{rating} #{@pluralize(rating, 'Stern', 'Sterne')}")
      if gon.categories?
        for category in gon.categories
          @renderFacet(gon.categoryFacets, 'categories', 'category', category.id, category.name)
        @renderFacet(gon.categoryFacets, 'categories', 'category', -1, "Keine Kategorie")
    if @collection.ratingFacet?
      @$('#title').html("Alle #{@collection.ratingFacet} #{@pluralize(@collection.ratingFacet, 'Stern', 'Sterne')} Movies")
      @$('#ratings').find(".#{@collection.ratingFacet}").addClass('selected')
      @$('#rating_facet').prepend("<a class=\"remove_facet remove_rating\">remove</a>")
    else if @collection.categoryFacet
      if @collection.categoryFacet == -1
        name = 'unkategorisierten'
      else
        category = $.grep gon.categories, (e) =>
          e.id == @collection.categoryFacet
        name = category[0].name
      @$('#title').html("Alle '#{name}' Movies")
      @$('#categories').find(".#{@collection.categoryFacet}").addClass('selected')
      @$('#category_facet').prepend("<a class=\"remove_facet remove_category\">remove</a>")
    if current_user
      @$('#movies-meta').html(_.template(JST['movies/new_button'](@model)))
    @

  renderFacet: (facets, element, dataName, dataValue, text) =>
    facet = $.grep facets, (e) ->
      e.term == dataValue
    count = if facet.length then facet[0].count else 0
    @$("##{element}").append("<li data-#{dataName}=\"#{dataValue}\" class=\"#{dataValue}\">#{text}  (#{count} #{@pluralize(count, 'Film', 'Filme')})</li>")

  removeCategoryFacet: (event) ->
    event.preventDefault()
    @collection.categoryFacet = null
    @collection.fetch()
    @render()

  removeRatingFacet: (event) ->
    event.preventDefault()
    @collection.ratingFacet = null
    @collection.fetch()
    @render()

  pagination: ->
    @$('.pager').show()
    pageInfo = @collection.pageInfo()
    page = pageInfo.page
    @$('.prev_page').toggleClass('disabled', page == 1)
    @$('.next_page').toggleClass('disabled', page == pageInfo.pages)
    @$('#page-num').html(page)

  appendMovie: (movie) ->
    view = new Imdb.Views.MovieIndex(model: movie)
    @$('#movies').append(view.render().el)

  noData: ->
    @$('#movies').append('<tr class="no_cursor"><td colspan="4" class="centered">Leider keine Filme gefunden</td></tr>')
    @$('.pager').hide()

  pluralize: (num, single, multiple) ->
    if num == 1
      single
    else
      multiple
