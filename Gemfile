source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> #{`cat .ruby-version`.strip}"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0", ">= 7.0.2.3"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~> 0.6"

# Use postgres as the database for Active Record
gem "pg", "~> 1.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", "~> 1.0"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails", "~> 1.1"

gem 'new_ckeditor', "~> 0.1"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 1.3"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.6"

gem 'devise_token_auth', "~> 1.2"

gem 'ransack'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem 'friendly_id', '~> 5.4.0'

gem "devise", git: 'https://github.com/ghiculescu/devise.git', branch: "error-code-422"
gem "image_processing", "~> 1.12"
gem "devise-bootstrapped", "~> 0.1"

gem 'aws-sdk-s3', "~> 1.113", require: false
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.11", require: false
gem 'pagy', '~> 5.10'
gem 'filestack-rails', '~> 5.5'

gem 'discard', '~> 1.2'
gem 'acts_as_list', "~> 1.0"
gem 'apipie-rails', "~> 0.8"
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "letter_opener", "~> 1.8"
  gem "debug", "~> 1.5", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2"

  gem 'annotate', '~> 3.2'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", "~> 3.36"
  gem "selenium-webdriver", "~> 4.1"
  gem "webdrivers", "~> 5.0"
end

gem 'httparty', '~> 0.20'

gem 'nokogiri', '~> 1.13', '>= 1.13.8'
gem "active_model_serializers", "~> 0.10"
