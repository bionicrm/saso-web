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

  # @return [String]
  def destination
    @destination ||= session[:destination]
  end

  # @param [String] destination
  def destination=(destination)
    @destination = destination

    if destination.nil?
      session.delete(:destination)
    else
      session[:destination] = destination
    end
  end

  # @return [Redirecting]
  def redirect_to_destination
    if destination
      tmp_destination = destination
      self.destination = nil

      return redirect_to tmp_destination
    end

    redirect_to root_path
  end

  # @param [User] user
  def current_user=(user)
    @current_user = user

    if user.nil?
      session.delete(:user_id)
    else
      session[:user_id] = user.id
    end
  end
end
