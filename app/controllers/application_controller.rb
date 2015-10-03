class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # @return [User]
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user, :logged_in?

  # @type [User] user
  def current_user=(user)
    @current_user = user

    if user.nil?
      session.delete(:user_id)
    else
      session[:user_id] = user.id
    end
  end

  # def get_unconnected_providers
  #   Provider.where('id NOT IN (?)', user.providers.pluck(:id)).all
  # end
end
