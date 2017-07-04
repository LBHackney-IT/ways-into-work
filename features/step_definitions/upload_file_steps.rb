When(/^I upload a cv file$/) do
  @file_name = 'CV.doc'
  page.attach_file(:file_upload_attachment, Rails.root.join('features', 'upload-files', @file_name))
  click_on I18n.t('files.buttons.upload_file')
end
