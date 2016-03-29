Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.pepper = '8fe56599f857812003ea817d085dbdfccd485ef1f469ba54410ad68669059bc88b035d093b8ef848a0c1ab5a8c8b3504da3
                   ab00d2c210543579e14ede49624e2'
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..20
  config.sign_out_via = :get, :delete
end
