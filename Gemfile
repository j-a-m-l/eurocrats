source "https://rubygems.org"

# Declare your gem's dependencies in eurocrat.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

gem 'geocoder'
gem 'countries'

group :development do
  gem 'spork'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-rails'
end

group :test do
  gem 'rack-test'
  # gem 'capybara'
  gem 'rspec'
  gem 'rspec-rails'
  # gem 'shoulda-matchers'
  # gem 'shoulda-callback-matchers'
  gem 'database_cleaner'
  # gem 'factory_girl_rails'
end

group :development, :test do
  gem 'sqlite3'

  # gem 'faker'
  gem 'ffaker'

  gem 'better_errors'
  gem 'did_you_mean'

  gem 'byebug'
  gem 'pry'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  # gem 'sdoc', require: false
end
