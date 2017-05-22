source 'https://rubygems.org'
ruby "2.4.1"
gem 'rails', '5.1'

# UI
# gem 'draper'
gem 'bitters'
gem 'bourbon'
gem 'neat'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'normalize-rails'
gem 'devise'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# DB
gem 'pg'

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'rspec-given',  :require => false
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem "webmock"
  gem "vcr"
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
end

# IF HEROKU
# group :production, :staging do
#   gem 'rails_12factor'
# end
