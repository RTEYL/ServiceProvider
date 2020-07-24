class Service < ApplicationRecord
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
