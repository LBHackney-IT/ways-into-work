require 'vcr'

dotenv = Rails.root.join('.env')
filter_vars = File.exist?(dotenv) ? Dotenv::Environment.new(dotenv, true) : ENV
  
VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.configure_rspec_metadata!
  filter_vars.each do |key, value|
    c.filter_sensitive_data("<#{key}>") { value }
  end
end
