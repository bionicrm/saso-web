class SessionsController < ApplicationController
  def create
    self.current_user = find_or_create_user!

    redirect_to_destination
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  private

  def find_or_create_user!
    auth = request.env['omniauth.auth']

    # @type [Service]
    service = Service.select(:id).find_or_create_by!(name: auth[:provider])

    # @type [ServiceUser]
    service_user = ServiceUser
                        .select(:id, :user_id, :auth_token_id)
                        .find_or_initialize_by(service: service,
                                               service_unique_id: auth[:uid])

    # @type [AuthToken]
    new_auth_token = AuthToken.new(access: auth[:credentials][:token],
                                   refresh: auth[:credentials][:refresh_token])

    if auth[:credentials][:expires]
      new_auth_token.expires_at = Time.at(auth[:credentials][:expires_at])
    end

    if service_user.new_record?
      # use currently logged in user or create new one
      # @type [User]
      user = current_user || User.create!(name: auth[:info][:name],
                                          email: auth[:info][:email])

      new_auth_token.save!
      service_user.update!(user: user, auth_token: new_auth_token)
    else
      service_user.auth_token.update!(
          new_auth_token.attributes.delete_if { |k, v| v.nil? } )
    end

    service_user.user
  end
end
