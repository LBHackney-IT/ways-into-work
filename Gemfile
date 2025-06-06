source 'https://rubygems.org'
ruby '2.6.6'
gem 'rails', '5.1.6.2'

# UI
gem 'devise'
gem 'draper'
gem 'font-awesome-rails'
gem "haml-rails", "~> 2.0"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails'
gem 'tinymce-rails'

gem 'simple_form', ">= 5.0.0"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# DB
gem 'pg'

gem 'httparty'
gem 'puma'

# validation tools
gem 'going_postal'
gem 'phony_rails'

gem 'active_model_serializers'
gem 'aws-sdk'
gem 'paperclip'

gem 'filterrific', git: 'https://github.com/wearefuturegov/filterrific'
gem 'humanize_boolean'

gem 'kaminari'
gem 'pg_search'

gem 'rack-cors'

gem 'appsignal'

gem 'decent_exposure'

gem 'paranoia'

gem 'rails_service_check', git: 'https://github.com/wearefuturegov/rails_service_check'

gem 'notifications-ruby-client'

gem 'hashids'

gem 'sendgrid_actionmailer_adapter'

gem 'active_record-acts_as'

gem 'mimemagic'

group :development, :staging, :test do
  gem 'fabrication'
  gem 'ffaker'
end

group :development do
  gem 'better_errors'
  gem 'bullet'
  gem 'i18n-debug'
  gem 'web-console'
  gem 'rack-mini-profiler'
  # gem 'binding_of_caller'
end

group :test do
  gem 'brakeman', require: false
  gem 'capybara-selenium'
  gem 'webdrivers'
  gem 'coderay'
  gem 'coveralls', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec', require: false
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-given', require: false
  gem 'rspec-rails', require: false
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'vcr', require: false
  gem 'webmock', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'pry'
end

# IF HEROKU
group :production, :staging do
  gem 'rails_12factor'
end
