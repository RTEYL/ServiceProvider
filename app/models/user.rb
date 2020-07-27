class User < ApplicationRecord
  has_many :service_requests
  has_many :reviews
	has_many :services, through: :reviews
  has_one :service
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true, presence: true


  def fullname
    "#{first_name}" + ' ' + "#{last_name}"
  end

end
