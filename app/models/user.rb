class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
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

  def self.create_from_provider_data(provider_data)
    wher(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
