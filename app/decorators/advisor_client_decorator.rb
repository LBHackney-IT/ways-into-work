class AdvisorClientDecorator < ClientDecorator

  def client_profile_header
    "#{client.name}'s Profile"
  end

  def new_file_button
    h.link_to I18n.t('clients.buttons.upload_cv'), h.new_advisor_client_file_upload_path(client), class: "button is-primary is-small"
  end

  def decorate_meetings_action
    if client.meetings.any?
      h.link_to I18n.t('clients.buttons.view_meetings'), h.advisor_client_meetings_path(client), method: :get, class: "button is-primary is-small"
    else
      h.button_to I18n.t('clients.buttons.arrange_meeting'), h.new_advisor_client_meeting_path(client), method: :get, class: "button is-primary is-small"
    end
  end
end
