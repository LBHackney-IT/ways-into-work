class AdvisorClientDecorator < ClientDecorator

  def client_profile_header
    "#{client.name}'s Profile"
  end

  def decorate_file_action
    if latest_cv.present?
      h.content_tag(:span, "CV: ") <<
      h.link_to("#{latest_cv.attachment_file_name}", latest_cv.attachment.try(:url), title: latest_cv.attachment_file_name, target: :blank) <<
      h.content_tag(:p, "Uploaded by: #{latest_cv.uploaded_by} on #{latest_cv.created_at.to_date.to_s(:short)}") <<
      h.button_to(I18n.t('clients.buttons.replace_cv'), h.advisor_client_file_upload_path(client, latest_cv), method: :delete, class: 'button is-primary is-small')
    else
      h.link_to I18n.t('clients.buttons.upload_cv'), h.new_advisor_client_file_upload_path(client), class: "button is-primary is-small"
    end
  end


  def latest_cv
    @latest_cv ||= client.file_uploads.first
  end
end
