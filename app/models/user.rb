class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  has_many :service_requests
  has_many :reviews
	has_many :services, through: :reviews
  has_one :service

  with_options if: :validations_required? do |user|
    has_secure_password validations: false
    user.validates_confirmation_of :password
    user.validates :first_name, presence: true
    user.validates :last_name, presence: true
    user.validates :email, uniqueness: true, presence: true
  end

  def validations_required?
    true if provider.blank?
  end

  def fullname
    "#{first_name}" + ' ' + "#{last_name}"
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email if !nil
      user.first_name = provider_data.info.nickname
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
