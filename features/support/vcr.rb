require 'vcr'

dotenv = Rails.root.join('.env')
filter_vars = File.exist?(dotenv) ? Dotenv::Environment.new(dotenv, true) : ENV

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'features/support/cassettes'
  filter_vars.each do |key, value|
    c.filter_sensitive_data("<#{key}>") { value }
  end
end

VCR.cucumber_tags do |t|
  t.tags '@homerton_postcode', '@validate_postcode', '@outside_hackney_postcode', '@client_cv', '@advisor_cv', '@haringey_postcode'
end
