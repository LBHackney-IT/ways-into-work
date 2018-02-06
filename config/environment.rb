# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WaysIntoWork::Application.initialize!

# Thursday 3rd May, at 2:48pm
Time::DATE_FORMATS[:long_with_day_time] = lambda { |time|
  time.strftime("%A #{time.day.ordinalize} %B at %-l:%M%P")
}

# at 2:48pm
Time::DATE_FORMATS[:at_time] = 'at %-l:%M%P'

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag.html_safe
end
