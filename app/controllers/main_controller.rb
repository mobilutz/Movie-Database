class MainController < ApplicationController
  def index
    gon.movies = Movie.search(params)
    gon.ratings = gon.movies.facets['rating']['terms']
    gon.total = gon.movies.total
    gon.categories = Category.all
    gon.categoryFacets = gon.movies.facets['category']['terms']
  end
end
