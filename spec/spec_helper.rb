require 'coveralls'
Coveralls.wear_merged!

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'simplecov'
SimpleCov.start 'rails'

require 'rspec/rails'
require 'devise'
require 'database_cleaner'

require 'email_spec'
require 'email_spec/rspec'

require 'webmock/rspec'

require Rails.root.join('spec', 'helpers', 'client_seeder_helper')
require Rails.root.join('spec', 'helpers', 'vcr')

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(
      :truncation,
      except: %w[ar_internal_metadata]
    )
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  
  original_stderr = $stderr
  original_stdout = $stdout
  
  config.before(:all, cli: true) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, 'w')
    $stdout = File.open(File::NULL, 'w')
  end
  
  config.after(:all, cli: true) do
    $stderr = original_stderr
    $stdout = original_stdout
  end

  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ClientSeederHelper

  # # rspec-expectations config goes here. You can use an alternate
  # # assertion/expectation library such as wrong or the stdlib/minitest
  # # assertions if you prefer.
  # config.expect_with :rspec do |expectations|
  #   # This option will default to `true` in RSpec 4. It makes the `description`
  #   # and `failure_message` of custom matchers include text for helper methods
  #   # defined using `chain`, e.g.:
  #   #     be_bigger_than(2).and_smaller_than(4).description
  #   #     # => "be bigger than 2 and smaller than 4"
  #   # ...rather than:
  #   #     # => "be bigger than 2"
  #   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  # end

  # # rspec-mocks config goes here. You can use an alternate test double
  # # library (such as bogus or mocha) by changing the `mock_with` option here.
  # config.mock_with :rspec do |mocks|
  #   # Prevents you from mocking or stubbing a method that does not exist on
  #   # a real object. This is generally recommended, and will default to
  #   # `true` in RSpec 4.
  #   mocks.verify_partial_doubles = true
  # end
end
