class User < ApplicationRecord
  has_many :service_requests
  has_many :reviews
	has_many :services, through: :reviews
  has_one :service
  has_secure_password
  validates :email, uniqueness: true

end
