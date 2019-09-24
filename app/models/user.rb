class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name,
            presence: true,
            length: { maximum: 12 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def email_required?
    false
  end

  def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.new(
        uid: auth.uid,
        provider: auth.provider,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name
      )
    end

    user
  end
end
