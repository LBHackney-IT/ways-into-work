require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'features/support/cassettes'
  # Filter out anything in the .env file
  Dotenv::Environment.new(File.join Rails.root, '.env').each do |key, value|
    c.filter_sensitive_data("<#{key}>") { value }
  end
end

VCR.cucumber_tags do |t|
  t.tags '@homerton_postcode', '@validate_postcode', '@outside_hackney_postcode'
end
