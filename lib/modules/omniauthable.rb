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
      pass = Devise.friendly_token(6)
      user = User.new(email: "#{SecureRandom.hex(3)}_#{oauth_data.provider}_email@social.login",
                      password: pass, password_confirmation: pass,
                      profile_attributes: { first_name: 'Change', last_name: 'This' })
      user.logged_with_social = true
      user.save!
      user
    end

    def register_social_profile(oauth, signed_up_with_social)
      social_profile = SocialProfile.where(provider: oauth.provider,
                                           uid: oauth.uid, user_id: id,
                                           signed_up_with_social: signed_up_with_social).first_or_create
      if social_profile.present?
        false
      else
        social_profile.update!(user_id: id)
      end

      social_profile.persisted? ? social_profile : false
    end

    def signed_up_with_social
      social_profile = social_profiles.find_by(signed_up_with_social: true)
      social_profile ? true : false
    end

    protected

    def password_required?
      super && !logged_with_social
    end
  end
end
