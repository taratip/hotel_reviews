class Hotel < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :address, :user
end
