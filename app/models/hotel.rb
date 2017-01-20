class Hotel < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates_presence_of :name, :address, :user
  validates :name, uniqueness: true
  mount_uploader :image , HotelPhotoUploader
end
