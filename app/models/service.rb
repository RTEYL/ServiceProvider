class Service < ApplicationRecord
  has_many :service_requests
  has_many :reviews
	has_many :users, through: :reviews
  belongs_to :user
  validates :service_type, :description, presence: true


  def self.search(search)
    if search
      search = where(service_type: "#{search}")
      search.empty? ? all : search
    else
      all
    end
  end

  def self.highest_rated_services
    all.order(:average_rating).limit(5)
  end

  def average_rating
    reviews.sum(:rating) / reviews.length unless reviews.length == 0
  end

  def review_count
    reviews.count
  end

end
