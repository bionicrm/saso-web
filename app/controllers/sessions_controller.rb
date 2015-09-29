class SessionsController < ApplicationController
  def create
    @user = ProviderUser.find_or_create_from_auth_hash!(auth_hash, session).user

    session[:user_id] = @user.id

    redirect_to root_path
    # render text: '<pre>' + auth_hash.to_yaml + '</pre>'
  end

  def destroy
    if user
      session.delete :user_id
    end

    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
