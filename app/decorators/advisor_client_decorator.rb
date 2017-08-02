class AdvisorClientDecorator < ClientDecorator

  def client_profile_header
    "#{client.name}'s Profile"
  end

  def new_file_button(label)
    h.link_to label, h.new_advisor_client_file_upload_path(client), class: "button is-primary is-small"
  end

  def post_file_to
    h.advisor_client_file_uploads_path(client)
  end

  def delete_file_button(file)
    h.button_to(I18n.t('clients.buttons.delete'), h.advisor_client_file_upload_path(client_id: id, id: file.id), class: 'button is-primary is-small', method: :delete)
  end

  def decorate_meetings_action
    if client.meetings.any?
      h.link_to I18n.t('clients.buttons.view_meetings'), h.advisor_client_meetings_path(client), method: :get, class: "button is-primary is-small"
    else
      h.button_to I18n.t('clients.buttons.arrange_meeting'), h.new_advisor_client_meeting_path(client), method: :get, class: "button is-primary is-small"
    end
  end
end
