class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  validates :title, presence: true
  validates :description, presence: true

  def resize
    return self.image.variant(resize: "800x1400")
  end
end
