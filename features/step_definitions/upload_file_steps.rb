When(/^I upload a cv file$/) do
  click_on I18n.t('clients.buttons.upload')
  @file_name = 'CV.doc'
  page.attach_file(:file_upload_attachment, Rails.root.join('features', 'upload_files', @file_name))
  click_on I18n.t('clients.buttons.upload')
end

When(/^I navigate to upload a file$/) do
  click_on I18n.t('clients.buttons.upload')
end

Then(/^a cv upload reference should be saved$/) do
  expect(FileUpload.count).to eq(1)
  expect(FileUpload.last.attachment_file_name).to eq(@file_name)
end

Then(/^I should see that I uploaded the file$/) do
  expect(page).to have_link(FileUpload.last.attachment_file_name)
end

When(/^I upload my cv file$/) do
  click_on I18n.t('clients.buttons.complete_profile')
  click_on I18n.t('clients.steps.employment.short')
  click_on I18n.t('clients.buttons.upload')
  @file_name = 'CV.doc'
  page.attach_file(:file_upload_attachment, Rails.root.join('features', 'upload_files', @file_name))
  click_on I18n.t('clients.buttons.upload')
end

Then(/^the CV upload reference should still be present$/) do
  expect(@client.file_uploads.count).to_not eq(0)
end
