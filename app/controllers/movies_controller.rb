class MoviesController < ApplicationController
  before_filter :logged_in?, except: [:index, :show]
  respond_to :json, :html

  def index
    @movies = Movie.search(params)
    gon.movies = @movies
    gon.ratings = @movies.facets['rating']['terms']
    @total = @movies.total
    gon.total = @total
    gon.categories = Category.all
    gon.categoryFacets = @movies.facets['category']['terms']
    respond_with @movies
  end

  def show
    # respond_with Movie.find(params[:id])
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    params[:movie][:category] = Category.find(params[:movie][:category][:id]) rescue nil
    respond_with Movie.create(params[:movie])
  end

  def update
    # respond_with Movie.update(params[:id], params[:movie])
    @movie = Movie.find(params[:id])
    if @movie.save
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    respond_to do |format|
      format.json
      format.html do
        redirect_to root_path, notice: 'Der Film wurde geloescht'
      end
    end
  end
end
