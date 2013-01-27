class RatingsController < ApplicationController
  def index

  end

  def new
    @rating = Movie.find(params[:movie_id]).ratings.build
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @rating = @movie.ratings.build(params[:rating].merge(user: current_user))
    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end
end
