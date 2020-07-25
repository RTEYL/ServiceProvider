class ServiceRequest < ApplicationRecord
  belongs_to :provider, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :service
end
