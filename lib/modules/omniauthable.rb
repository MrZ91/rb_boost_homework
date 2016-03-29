module Omniauthable
  extend ActiveSupport::Concern

  included do
    attr_accessor :logged_with_social

    def self.find_or_create_with_oauth(oauth_data)
      find_with_oauth(oauth_data) || create_with_oauth(oauth_data)
    end

    def self.find_with_oauth(oauth_data)
      social_profile = SocialProfile.where(provider: oauth_data.provider, uid: oauth_data.uid).first
      social_profile.present? ? social_profile.user : nil
    end

    def self.create_with_oauth(oauth_data)
      user = User.new(email: "#{SecureRandom.hex(3)}_#{oauth_data.provider}_email@social.login")
      user.logged_with_social = true
      user.save!
      user
    end

    def register_social_profile(oauth)
      social_profile = SocialProfile.where(provider: oauth.provider,
                                           uid: oauth.uid).first_or_create

      if social_profile.user_id.present? && social_profile.user_id != id
        false
      else
        social_profile.update!(user_id: id)
      end
      social_profile.persisted? ? social_profile : false
    end

    protected

    def password_required?
      super && !logged_with_social
    end
  end
end
