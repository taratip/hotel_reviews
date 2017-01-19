class Hotel < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :address, :user

  mount_uploader :image , HotelPhotoUploader
end
