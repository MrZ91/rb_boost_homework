Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, OmnyAuthConfig['facebook']['key'], OmnyAuthConfig['facebook']['secret']
  provider :twitter, OmnyAuthConfig['twitter']['key'], OmnyAuthConfig['twitter']['secret']
end

