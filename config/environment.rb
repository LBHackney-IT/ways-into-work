# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WaysIntoWork::Application.initialize!

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag.html_safe
end
