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
    find_or_initialize_by(uid: auth.uid, provider: auth.provider) do |user|
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
