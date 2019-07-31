class User < ApplicationRecord
  validates: name,
    presence: true,
    length: { maximum 12 }
  validates: email,
    presence: true,
    uniquness: true
end
