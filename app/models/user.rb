class User < ApplicationRecord
  has_many :service_requests
  has_many :providers, through: :service_requests
  has_secure_password
end
