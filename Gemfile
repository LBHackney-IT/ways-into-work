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

gem 'simple_form'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# DB
gem 'pg'

# validation tools
gem 'phony_rails'

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'rspec-given',  :require => false
  gem 'rspec-rails', require: false
  gem 'email_spec', require: false
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'launchy'
  gem 'coderay'
  gem "webmock", require: false
  gem "vcr", require: false
end

group :development, :test do
  gem 'ffaker'
  gem 'fabrication'
  gem 'byebug'
  gem 'dotenv-rails'
end

# IF HEROKU
# group :production, :staging do
#   gem 'rails_12factor'
# end
