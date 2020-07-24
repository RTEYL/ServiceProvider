class User < ApplicationRecord
  has_many :service_requests
  has_one :service
  has_secure_password

end
