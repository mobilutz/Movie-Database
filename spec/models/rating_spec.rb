require 'spec_helper'

describe Rating do
  context 'Validations' do
    it 'should check for presence of user' do
      movie = Movie.new(title: 'MyMovie')
      rating = Rating.new(number: 5, movie: movie)
      rating.valid?.should be_false
    end

    it 'should check for presence of movie' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      rating = Rating.new(number: 5, user: user)
      rating.valid?.should be_false
    end

    it 'should check for presence of rating' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      movie = Movie.new(title: 'MyMovie')
      rating = Rating.new(user: user, movie: movie)
      rating.valid?.should be_false
    end

    it 'should check for the type of the rating' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      movie = Movie.new(title: 'MyMovie')
      rating = Rating.new(user: user, movie: movie, number: 'a')
      rating.valid?.should be_false
    end

    it 'should check for rating that are greater than 5' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      movie = Movie.new(title: 'MyMovie')
      rating = Rating.new(user: user, movie: movie, number: 6)
      rating.valid?.should be_false
    end

    it 'should be a valid rating' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      movie = Movie.new(title: 'MyMovie')
      rating = Rating.new(user: user, movie: movie, number: 1)
      rating.valid?.should be_true
    end
  end
end
