class Provider < ActiveRecord::Base
  has_many :provider_users
  has_many :users, through: :provider_users
end
