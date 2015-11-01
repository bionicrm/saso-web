class AuthToken < ActiveRecord::Base
  has_one :service_user
end
