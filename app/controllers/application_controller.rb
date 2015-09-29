class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # @return [User]
  def user
    @user ||= User.find_by id: session[:user_id]
  end

  def get_unconnected_providers
    Provider.where('id NOT IN (?)', user.providers.pluck(:id)).all
  end

  helper_method :user
  helper_method :get_unconnected_providers
end
