class ServiceUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  belongs_to :auth_token
end
