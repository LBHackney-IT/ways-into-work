require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'messages'))

module MessagesSH
  def check_for_flash_message(type, text)
    expect(page.find("#flash_#{type}")).to have_content(message_content_for(text))
  end

  def check_for_content(text)
    expect(page).to have_content(message_content_for(text))
  end

  def check_for_no_flash_message(type, text)
    expect(page.find("#flash_#{type}")).not_to have_content(message_content_for(text))
  end

  def check_for_no_content(text)
    expect(page).not_to have_content(message_content_for(text))
  end
end
World(MessagesSH)

Then /^I should see the (.+) error message$/ do |text|
  check_for_flash_message('error', text)
end

Then /^I should see the (.+) success message$/ do |text|
  check_for_flash_message('success', text)
end

Then /^I should see the (.+) notice message$/ do |text|
  check_for_flash_message('notice', text)
end

Then /^I should see the (.+) alert message$/ do |text|
  check_for_flash_message('alert', text)
end

Then /^I should see (?:a|an) (.+) message$/ do |text|
  check_for_content(text)
end

Then /^I not should see the (.+) error message$/ do |text|
  check_for_no_flash_message('error', text)
end

Then /^I not should see the (.+) success message$/ do |text|
  check_for_no_flash_message('success', text)
end

Then /^I not should see the (.+) notice message$/ do |text|
  check_for_no_flash_message('notice', text)
end

Then /^I not should see the (.+) alert message$/ do |text|
  check_for_no_flash_message('alert', text)
end

Then /^I not should see (?:a|an) (.+) message$/ do |text|
  check_for_no_content(text)
end
