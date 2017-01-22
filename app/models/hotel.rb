class Hotel < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  
  validates_presence_of :name, :address, :user
  validates :name, uniqueness: true
  mount_uploader :image , HotelPhotoUploader
end
