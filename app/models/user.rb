class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name,
            presence: true,
            length: { maximum: 12 }
  validates :email,
            presence: true,
            uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
