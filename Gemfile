source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> #{`cat .ruby-version`.strip}"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0", ">= 7.0.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.4"

# Use sqlite3 as the database for Active Record
gem "pg", "~> 1.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 1.0"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 1.0"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.11"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.6"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "devise", git: 'https://github.com/ghiculescu/devise.git', branch: "error-code-422"
gem "image_processing", "~> 1.12"
gem "devise-bootstrapped", "~> 0.1"

gem 'aws-sdk-s3', require: false
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.11", require: false
gem 'cocoon', '~> 1.2'
gem 'pagy', '~> 5.10'
gem 'filestack-rails', '~> 5.5'

# Use Sass to process CSS
gem "sassc-rails"

gem 'discard', '~> 1.2'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.4", platforms: %i[ mri mingw x64_mingw ]
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

gem "jsbundling-rails", "~> 1.0"
gem "select2-rails"