class User < ApplicationRecord
  has_many :services_requests
  has_many :providers, through: :service_requests
  has_secure_password
end
