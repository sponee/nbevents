class User < ActiveRecord::Base

  has_many :nation_api_tokens, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = where(email: auth.info.email).first_or_initialize
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
