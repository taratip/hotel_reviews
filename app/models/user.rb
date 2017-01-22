class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :hotels, dependent: destroy
  has_many :reviews, dependent: destroy
  has_many :votes

  validates :email, uniqueness: true
  validates :role, inclusion: { in: ['member', 'admin'] }

  def admin?
    role == "admin"
  end
end
