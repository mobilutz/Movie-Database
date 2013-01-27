class Imdb.Collections.Movies extends Backbone.Collection
  baseUrl: '/api/movies'
  model: Imdb.Models.Movie

  initialize: (options)->
    @page = 1
    @perPage = 10
    @total = options.total
    @ratingFacet = null
    @categoryFacet = null

  fetch: (options = {}) ->
    @trigger "fetching"
    self = @
    success = options.success
    options.success = (resp) ->
      self.trigger "fetched"
      success(self, resp) if success
    Backbone.Collection.prototype.fetch.call @, options

  parse: (resp) ->
    if resp.length > 0
      @total = resp[0].total
    else
      @total = 0
    @pages = Math.ceil @total / @perPage
    resp

  url: ->
     @baseUrl + '?' + $.param({page: @page, perPage: @perPage, rating_avg: @ratingFacet, category_id: @categoryFacet})

  pageInfo: ->
    info =
      total: @total
      page: @page
      perPage: @perPage
      pages: Math.ceil @total / @perPage
      prev: false
      next: false
    max = Math.min @total, @page * @perPage
    max = @total if @total == @pages * @perPage
    info.range = [(@page - 1) * @perPage + 1, max]
    info.prev = @page - 1 if @page > 1
    info.next = @page + 1 if @page < info.pages

    info

  nextPage: ->
    if !@pageInfo().next
      false
    else
      @page = @page + 1
      @fetch()

  previousPage: ->
    if !@pageInfo().prev
      false
    else
      @page = @page - 1
      @fetch()
