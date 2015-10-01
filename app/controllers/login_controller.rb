class LoginController < ApplicationController
  def index
    redirect_to root_path if logged_in?
  end
end
