class User < ApplicationRecord
  has_secure_password

  validates: name,
    presence: true,
    length: { maximum 12 }
  validates: email,
    presence: true,
    uniquness: true
end
