class ProviderUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  belongs_to :auth_token
end
