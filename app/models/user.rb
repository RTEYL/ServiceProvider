class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  has_many :service_requests
  has_many :reviews
	has_many :services, through: :reviews
  has_one :service
  validates :first_name, :last_name, presence: true, if: -> {provider.blank?}
  validates :email, uniqueness: true, presence: true, allow_blank: true, if: -> {provider.blank?}

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
