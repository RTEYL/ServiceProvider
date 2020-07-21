class Provider < ApplicationRecord
  has_one :service
  has_many :service_requests
  has_many :users, through: :service_requests
  has_secure_password
end
