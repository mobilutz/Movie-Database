# encoding: utf-8

class UsersController < ApplicationController
  respond_to :html, :json

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Vielen Dank für die Anmeldung! Sie sind jetzt automatisch schon eingelogt.'
    else
      render 'new'
    end
  end
end
