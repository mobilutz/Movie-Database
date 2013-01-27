require "spec_helper"

describe MoviesController do
  describe "routing" do

    it "routes to #index" do
      get("/api/movies.json").should route_to("movies#index", format: 'json')
    end

    it "routes to #show" do
      get("/movies/1").should route_to("movies#show", id: "1")
    end

    it "routes to #create" do
      post("/api/movies.json").should route_to("movies#create", format: 'json')
    end

    it "routes to #update" do
      put("/movies/1").should route_to("movies#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/movies/1").should route_to("movies#destroy", id: '1')
    end

  end
end
