module Omniauthable
  extend ActiveSupport::Concern

  included do
    attr_accessor :logged_with_social

    def self.find_or_create_with_oauth(provider, uid)
      find_with_oauth(provider, uid) || create_with_oauth(provider, uid)
    end

    def self.find_with_oauth(provider, uid)
      social_profile = SocialProfile.where(provider: provider, uid: uid).first
      social_profile.present? ? social_profile.user : nil
    end

    def self.create_with_oauth(provider, _uid)
      user = User.new(email: "#{SecureRandom.hex(3)}_#{provider}_email@social.login")
      user.logged_with_social = true
      user.save!
      user
    end

    def register_social_profile(provider, uid)
      social_profile = SocialProfile.where(provider: provider,
                                           uid: uid).first_or_create

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
