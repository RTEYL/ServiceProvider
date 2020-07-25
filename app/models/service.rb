class Service < ApplicationRecord
  has_many :service_requests
  has_many :users, through: :service_requests
  belongs_to :user

  def self.search(search)
    if search
      search = where(service_type: "#{search}")
      if search.empty?
        all
      else
        search
      end
    else
      all
    end
  end

end
