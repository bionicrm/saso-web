class User < ActiveRecord::Base
  belongs_to :provider
  has_many :live_tokens
  has_many :provider_users
  has_many :providers, through: :provider_users

  alias_attribute :main_provider, :provider
  alias_attribute :main_provider_id, :provider_id
end
