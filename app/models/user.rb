class User < ApplicationRecord
  has_many :providers, foreign_key: 'provider_id'
  has_many :creators, foreign_key: 'creator_id'
  has_many :service_requests
  has_many :services, through: :service_requests
  has_one :service
  has_secure_password

end
