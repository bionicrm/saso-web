class ProviderUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider

  class << self
    def find_or_create_from_auth_hash!(auth_hash, session)
      # @type [Provider]
      provider = Provider.find_or_create_by name: auth_hash[:provider]

      # @type [ProviderUser]
      provider_user = find_or_initialize_by provider: provider,
                                            provider_unique_id: auth_hash[:uid]

      hash_name = auth_hash[:info][:name]
      hash_email = auth_hash[:info][:email]
      hash_token = auth_hash[:credentials][:token]
      # FIXME: seems to not get the correct value
      hash_refresh_token = auth_hash[:credentials][:secret] || auth_hash[:credentials][:refresh_token]

      if provider_user.new_record?
        # use currently logged in user or create new one
        user = User.find_by id: session[:user_id] if session[:user_id]

        user ||= User.create(name: hash_name,
                             email: hash_email)

        # set new provider_user details
        provider_user.user = user
        provider_user.access_token = hash_token
        provider_user.refresh_token = hash_refresh_token

        # save new provider_user
        provider_user.save!
      else
        user = provider_user.user

        # update provider_user's user details
        user.name = hash_name
        user.email = hash_email

        user.save!

        # update provider_user details
        provider_user.access_token = hash_token

        provider_user.save!
      end

      provider_user
    end
  end
end
