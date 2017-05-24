# Commonly used email steps
#
# To add your own steps make a custom_email_steps.rb
# The provided methods are:
#
# last_email_address
# reset_mailer
# open_last_email
# visit_in_email
# unread_emails_for
# mailbox_for
# current_email
# open_email
# read_emails_for
# find_email
#
# General form for email scenarios are:
#   - clear the email queue (done automatically by email_spec)
#   - execute steps that sends an email
#   - check the user received an/no/[0-9] emails
#   - open the email
#   - inspect the email contents
#   - interact with the email (e.g. click links)
#
# The Cucumber steps below are setup in this order.

module EmailHelpers
  def current_email_address
    # Replace with your a way to find your current email. e.g @current_user.email
    # last_email_address will return the last email address used by email spec to find an email.
    # Note that last_email_address will be reset after each Scenario.
    last_email_address || "example@example.com"
  end

  def has_link(email, link)
    expect(links_in_email(email).grep(link)).to be_present
  end

end

World(EmailHelpers)

When(/^I click the opt\-in email confirmation link$/) do
  address = UserLogin.last.email
  expect(unread_emails_for(address).size).to eq(1)
  open_email(address)
  visit request_uri(links_in_email(current_email).first)
end


#
# Reset the e-mail queue within a scenario.
# This is done automatically before each scenario.
#

Given /^(?:a clear email queue|no emails have been sent)$/ do
  reset_mailer
end

#
# Check how many emails have been sent/received
#

Then(/^"(.*?)" should recieve (\d+) emails$/) do |address, amount|
  expect(unread_emails_for(address).size).to eq parse_email_count(amount)
end

Then(/^"(.*?)" receive an email asking to confirm address$/) do |address|
  expect(unread_emails_for(address).size).to eq(1)
end

Then(/^(?:I|they|"([^"]*?)") should receive an email with the following body:$/) do |address, expected_body|
  open_email(address, :with_text => expected_body)
end

#
# Accessing emails
#

# Opens the most recently received email
When(/^(?:I|they|"([^"]*?)") opens? the email$/) do |address|
  open_email(address)
end

When(/^(?:I|they|"([^"]*?)") opens? the email with subject "([^"]*?)"$/) do |address, subject|
  open_email(address, :with_subject => subject)
end

When(/^(?:I|they|"([^"]*?)") opens? the email with subject \/([^"]*?)\/$/) do |address, subject|
  open_email(address, :with_subject => Regexp.new(subject))
end
#
# Inspect the Email Contents
#

Then(/^(?:I|they) should see "([^"]*?)" in the email subject$/) do |text|
  expect(current_email).to have_subject(text)
end

Then(/^(?:I|they) should see \/([^"]*?)\/ in the email subject$/) do |text|
  expect(current_email).to have_subject(Regexp.new(text))
end

Then(/^(?:I|they) should see "([^"]*?)" in the email body$/) do |text|
  expect(current_email.default_part_body.to_s).to include(text)
end

Then(/^the email should contain the pdf download services link$/) do
  expect(current_email.default_part_body.to_s).to include(results_download_path(events: '', services: ''))
end

Then(/^the email should contain the pdf download pinboard link$/) do
  expect(current_email.default_part_body.to_s).to include(results_download_path(events: '1', services: '1'))
end

Then(/^the email should contain (\d+) services?$/) do |num|
  expect(current_email.default_part_body.to_s.scan(/<div class=\"service\">/).count).to eq(num.to_i)
end

Then(/^the email should contain an event and a service$/) do
  expect(current_email.default_part_body.to_s.scan(/<div class=\"service\">/).count).to eq(1)
  expect(current_email.default_part_body.to_s.scan(/<div class=\"event\">/).count).to eq(1)
end

Then /^(?:I|they) should see \/([^"]*?)\/ in the email body$/ do |text|
  expect(current_email.default_part_body.to_s).to =~ Regexp.new(text)
end

Then /^(?:I|they) should see the email delivered from "([^"]*?)"$/ do |text|
  expect(current_email).to be_delivered_from(text)
end

Then /^(?:I|they) should see "([^\"]*)" in the email "([^"]*?)" header$/ do |text, name|
  expect(current_email).to have_header(name, text)
end

Then /^(?:I|they) should see \/([^\"]*)\/ in the email "([^"]*?)" header$/ do |text, name|
  expect(current_email).to have_header(name, Regexp.new(text))
end

Then /^I should see it is a multi\-part email$/ do
    expect(current_email).to be_multipart
end

Then /^(?:I|they) should see "([^"]*?)" in the email html part body$/ do |text|
    expect(current_email.html_part.body.to_s).to include(text)
end

Then /^(?:I|they) should see "([^"]*?)" in the email text part body$/ do |text|
    expect(current_email.text_part.body.to_s).to include(text)
end


Then /^show me a list of email attachments$/ do
  EmailSpec::EmailViewer::save_and_open_email_attachments_list(current_email)
end

#
# Interact with Email Contents
#

When /^(?:I|they|"([^"]*?)") follows? "([^"]*?)" in the email$/ do |address, link|
  visit_in_email(link, address)
end

#
# Debugging
# These only work with Rails and OSx ATM since EmailViewer uses RAILS_ROOT and OSx's 'open' command.
# Patches accepted. ;)
#

Then /^save and open current email$/ do
  EmailSpec::EmailViewer::save_and_open_email(current_email)
end

Then /^save and open all text emails$/ do
  EmailSpec::EmailViewer::save_and_open_all_text_emails
end

Then /^save and open all html emails$/ do
  EmailSpec::EmailViewer::save_and_open_all_html_emails
end

Then /^save and open all raw emails$/ do
  EmailSpec::EmailViewer::save_and_open_all_raw_emails
end
