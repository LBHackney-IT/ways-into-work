When(/^I upload a cv file$/) do
  click_on I18n.t('clients.buttons.upload_cv')
  @file_name = 'CV.doc'
  page.attach_file(:file_upload_attachment, Rails.root.join('features', 'upload_files', @file_name))
  click_on I18n.t('clients.buttons.upload_cv')
end

Then(/^a cv upload reference should be saved$/) do
  expect(FileUpload.count).to eq(1)
  expect(FileUpload.last.attachment_file_name).to eq(@file_name)
end

Then(/^I should see that I uploaded the file$/) do
  expect(page).to have_link(FileUpload.last.attachment_file_name)
end
