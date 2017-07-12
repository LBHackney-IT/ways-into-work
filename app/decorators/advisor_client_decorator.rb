class AdvisorClientDecorator < ClientDecorator

  def client_profile_header
    "#{client.name}'s Profile"
  end

  def new_file_button
    h.link_to I18n.t('clients.buttons.upload_cv'), h.new_advisor_client_file_upload_path(client), class: "button is-primary is-small"
  end
end
