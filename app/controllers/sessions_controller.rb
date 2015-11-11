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

    proper_name, logo_file = get_provider_info auth[:provider].to_s

    # @type [Service]
    service = Service.select(:id).find_or_create_by!(name: auth[:provider],
                                                     proper_name: proper_name,
                                                     logo_file: logo_file)

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

    puts service_user
    puts service_user.user

    service_user.user
  end

  def get_provider_info(provider)
    case provider
      when 'github'
        return 'GitHub', 'github.svg'
      when 'twitter'
        return 'Twitter', 'twitter.png'
      when 'google'
        return 'Google', 'google.png'
      when 'digitalocean'
        return 'DigitalOcean', 'digitalocean.png'
      when 'facebook'
        return 'Facebook', 'facebook.svg'
      else
        raise "Unknown provider '#{provider}'"
    end
  end
end
