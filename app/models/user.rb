class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    length: { maximum: 12 }
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
