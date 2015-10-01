class SessionsController < ApplicationController
  def create
    self.current_user = find_or_create_user!

    redirect_to root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def find_or_create_user!
    auth = {
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        name: auth_hash[:info][:name],
        email: auth_hash[:info][:email],
        token: auth_hash[:credentials][:token],
        # FIXME: seems to not get the correct value?
        refresh_token: auth_hash[:credentials][:secret] || auth_hash[:credentials][:refresh_token]
    }

    # @type [Provider]
    provider = Provider.find_or_create_by name: auth.provider

    # @type [ProviderUser]
    provider_user = ProviderUser.find_or_initialize_by provider: provider,
                                                       provider_unique_id: auth.uid

    if provider_user.new_record?
      # use currently logged in user or create new one
      # @type [User]
      user = current_user || User.create(main_provider_id: provider,
                                         name: auth.name,
                                         email: auth.email)

      # set new provider_user details
      provider_user.user = user
      provider_user.access_token = auth.token
      provider_user.refresh_token = auth.refresh_token

      provider_user.save!
    else
      # @type [User]
      user = provider_user.user

      # @type [Provider]
      main_provider = user.main_provider

      # if the provider used for the request is the user's main provider...
      if provider.name == main_provider.name
        # update user's details
        user.name = auth.name
        user.email = auth.email

        user.save!
      end

      # update provider_user details
      provider_user.access_token = auth.token

      provider_user.save!
    end

    provider_user.user
  end
end
