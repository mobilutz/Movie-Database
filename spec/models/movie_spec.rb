require 'spec_helper'

describe Movie do
  context 'Methods' do
    before(:each) do
      user = User.create!(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      category = Category.create!(name: 'Category')
      movie = Movie.create!(title: 'MyTitle', text: 'MyText', category: category)
      rating = Rating.create!(number: 5, movie: movie, user: user)
    end

    it 'returns correct indexing values' do
      movie = Movie.last
      Rails.logger.error "DEBUG #{movie.methods}"
      movie.to_indexed_json.should include('rating_count')
      movie.to_indexed_json.should include('rating_avg')
      movie.to_indexed_json.should include('category_id')
      movie.to_indexed_json.should include('category_name')
    end

    it 'should check if movie is already rated by a user' do
      movie = Movie.last
      user = User.last
      movie.rated_by?(user).should be_true
    end

    it 'should check that a movie is not yet rated by different user' do
      user2 = User.create!(email: 'a@b.de', password: 'passwort', password_confirmation: 'passwort')
      movie = Movie.last
      movie.rated_by?(user2).should be_false
    end
  end
  context 'Validations' do
    it 'should check for presence of title' do
      movie = Movie.new(text: 'MyText')
      movie.valid?.should be_false
    end

    it 'should check for uniqueness of title' do
      movie = Movie.create!(title: 'MyTitle')
      movie2 = Movie.new(title: 'MyTitle')
      movie2.valid?.should be_false
    end
  end
end
