require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir     = 'features/support/cassettes'
end

VCR.cucumber_tags do |t|
  t.tags '@validate_postcode'
end
