class User < ActiveRecord::Base
  include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :instagram]

  before_save :ensure_authentication_token

  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      if user.email == nil
        user.email = auth.info.nickname + "@#{auth.provider}.com"
      end
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.imag
      #binding.pry
      user.save!
    end
  end
end
