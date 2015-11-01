class User < ActiveRecord::Base
  has_many :live_tokens
  has_many :service_users
  has_many :services, through: :service_users
  has_many :auth_tokens, through: :service_users
end
