require 'spec_helper'

describe MoviesController do

  def valid_attributes
    { "title" => "MyString" }
  end

  def valid_session
    {user_id: User.last.id}
  end

  before(:each) do
    user = User.create!( email: 'test@test.de', password: 'gehheim', password_confirmation: 'gehheim' )
    Rails.logger.error "DEBUG #{user.id}"
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      movie = Movie.create! valid_attributes
      get :show, {:id => movie.to_param}, valid_session
      assigns(:movie).should eq(movie)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, {:movie => valid_attributes}, valid_session
        }.to change(Movie, :count).by(1)
      end

      it "creates a new movie" do
        post :create, {:movie => valid_attributes}, valid_session
        response.status.should eq(302)
      end

      it "redirects to the created movie" do
        post :create, {:movie => valid_attributes}, valid_session
        response.should redirect_to(Movie.last)
      end
    end

    describe "with invalid params" do
      it "returns status code 302" do
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        post :create, {:movie => { "text" => "invalid value" }}, valid_session
        response.status.should eq(302)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        assigns(:movie).should eq(movie)
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        response.should redirect_to(movie)
      end
    end

    describe "with invalid params" do
      it "assigns the movie as @movie" do
        movie = Movie.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        put :update, {:id => movie.to_param, :movie => { "title" => "invalid value" }}, valid_session
        assigns(:movie).should eq(movie)
      end

      it "re-renders the 'edit' template" do
        movie = Movie.create! valid_attributes
        Movie.any_instance.stub(:save).and_return(false)
        put :update, {:id => movie.to_param, :movie => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete :destroy, {:id => movie.to_param}, valid_session
      }.to change(Movie, :count).by(-1)
    end

    it "redirects to the movies list" do
      movie = Movie.create! valid_attributes
      delete :destroy, {:id => movie.to_param}, valid_session
      response.should redirect_to(root_url)
    end
  end

end
