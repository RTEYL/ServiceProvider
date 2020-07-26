class Service < ApplicationRecord
  has_many :service_requests
  has_many :reviews
	has_many :users, through: :reviews
  belongs_to :user

  def self.search(search)
    if search
      search = where(service_type: "#{search}")
      search.empty? ? all : search
    else
      all
    end
  end

end
