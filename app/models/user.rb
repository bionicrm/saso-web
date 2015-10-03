class User < ActiveRecord::Base
  has_many :live_tokens
  has_many :provider_users
  has_many :providers, through: :provider_users
end
