class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    length: { maximum: 12 }
  validates :email,
    presence: true,
    uniqueness: true

  has_many :posts, dependent: :destroy
end
