class User < ActiveRecord::Base
  include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :instagram]

  before_save :ensure_authentication_token

  mount_uploader :image, ImageUploader

  after_create :signup_confirmation

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email
      if user.email == nil
        user.email = auth.info.nickname + "@#{auth.provider}.com"
      end
      user.password = Devise.friendly_token[0,20]
      user.remote_image_url = auth.info.image.gsub('http://','https://')
    end
  end

  def signup_confirmation
    UserMailer.signup_confirmation(self).deliver_now
  end

end
