source 'http://rubygems.org'
# ruby '2.2.3'

gem 'rails', '4.2.5'
gem 'uglifier'

gem 'simple_form'

gem 'pg', '0.17.1'
gem 'puma', '1.5.0'

gem 'kaminari'

gem 'carrierwave', '0.9.0'
gem 'date_validator'
gem 'aasm'

gem 'sidekiq', '~>3.5.4'
gem 'sidekiq-status'
gem 'sidekiq-failures'
gem 'sidekiq-unique-jobs'
gem 'sinatra', require: false
gem 'slim'
gem 'foreman'

gem 'sass'
# gem 'mini_magick'
gem 'rmagick'

gem 'sass-rails'
gem 'haml-rails'
gem 'coffee-rails'
gem 'font-awesome-sass'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'
gem 'jasny-bootstrap-rails'
gem 'bootstrap_notify'

gem 'cancancan'
gem 'rolify'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

group :production, :release, :staging do
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
end

group :test, :development do
  gem 'simplecov'
  gem 'rails_dt'
  gem 'byebug'
  gem 'pry'
  gem 'spring'
  gem 'faker'
  gem 'quiet_assets'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_girl_rails'
  gem 'letter_opener'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'annotate'
  gem 'better_errors'
  gem 'spring-commands-rspec'
  gem 'bullet'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
end
