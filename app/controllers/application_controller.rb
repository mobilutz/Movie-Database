class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue
    session[:user_id] = nil
    @current_user = nil
  end
  helper_method :current_user

  def logged_in?
    Rails.logger.error "DEBUG #{session.pretty_inspect}"
    if current_user.blank?
      render json: 'unauthorized access', status: :forbidden
      false
    end
  end
end
