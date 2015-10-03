class AuthToken < ActiveRecord::Base
  has_one :provider_user
end
