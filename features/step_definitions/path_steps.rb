require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module PathsSH
  def on_path?(path)
    current_path = URI.parse(current_url).request_uri
    expect(current_path).to eq(path)
  end
end
World PathsSH

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )return to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  uri = URI.parse(current_url)
  current_path = uri.path
  # current_path += "?#{uri.query}" if uri.query
  expect(current_path).to eq path_to(page_name)
end

Then(/^(?:|I )should see a link to (.+)$/) do |page_name|
  matcher = all(:css, "a[href='#{path_to(page_name)}']")
  expect(matcher.count).to be > 0
end

Then(/^(?:|I )should not see a link to (.+)$/) do |page_name|  
  matcher = all(:css, "a[href='#{path_to(page_name)}']")
  expect(matcher.count).to eq 0
end
