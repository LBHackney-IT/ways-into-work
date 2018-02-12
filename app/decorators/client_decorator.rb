class ClientDecorator < ApplicationDecorator
  delegate_all

  decorates :client

  def return_to_client_button
    h.link_to I18n.t('clients.buttons.back'), h.edit_client_employment_status_path, class: 'button pull-right'
  end

  def decorate_name
    standard_wrapper('Name:', client.name)
  end

  def decorate_first_name
    standard_wrapper('First Name:', client.first_name)
  end

  def decorate_last_name
    standard_wrapper('Last Name:', client.last_name)
  end

  def decorate_national_insurance_number
    standard_wrapper('National Insurance Number:', client.national_insurance_number)
  end

  def decorate_date_registered
    standard_wrapper('Date registered:', client.created_at.to_date.to_formatted_s(:long))
  end

  def decorate_email
    standard_wrapper('Email account:', client.email)
  end

  def decorate_phone
    standard_wrapper('Phone number:', client.phone_number)
  end

  def decorate_address
    standard_wrapper('Address:', client.address_to_s)
  end

  def decorate_age
    return unless client.date_of_birth
    standard_wrapper('Date of Birth:', "#{client.date_of_birth.to_date.to_formatted_s(:long)} (#{client.age_in_years} years old)")
  end

  def decorate_support_priorities
    standard_wrapper('Support priorities:', SupportOption.display(client.support_priorities))
  end

  def decorate_types_of_work
    standard_wrapper('Industry preference:', TypeOfWorkOption.display(client.types_of_work))
  end

  # def decorate_rag_status
  #   standard_wrapper("Status:", client.rag_status)
  # end

  def decorate_studying
    standard_wrapper('Currently studying:', value_from(client.studying))
  end

  def decorate_past_education
    standard_wrapper('Past education:', client.past_education)
  end

  def decorate_currently_employed
    standard_wrapper('Currently employed:', value_from(client.employed))
  end

  def decorate_meeting_date(meeting)
    if meeting.start_datetime && meeting.start_datetime < DateTime.now
      "Last meeting:"
    else
      "Next meeting:"
    end
  end

  def decorate_meeting_agenda(meeting)
    string = "Agenda: "
    string += MeetingAgendaOption.find(meeting.agenda).try(:name) || meeting.other_agenda
  end

  def decorate_task_title
    if client.action_plan_tasks.ongoing.any?
      "Next task to complete:"
    else
      "Most recently completed task:"
    end
  end

  def decorate_single_task_due_date
    h.content_tag :p do
      "Due date: " + client.action_plan_tasks.ongoing.first.due_date.to_date.to_s(:short)
    end
  end

  def decorate_single_task_title
    h.content_tag :p, client.action_plan_tasks.ongoing.first.title
  end

  def decorate_single_task
    if client.action_plan_tasks.ongoing.any?
      h.link_to h.edit_advisor_client_action_plan_task_path(client_id: client.id, id: client.action_plan_tasks.ongoing.first.id) do
        decorate_single_task_title
      end
    else
      h.link_to client.action_plan_tasks.completed.first.title, h.edit_advisor_client_action_plan_task_path(client_id: client.id, id: client.action_plan_tasks.completed.first.id)
    end
  end

  def decorate_single_task_no_links
    if client.action_plan_tasks.ongoing.any?
      decorate_single_task_title
    else
      client.action_plan_tasks.completed.first.title
    end
  end



  def decorate_preferred_contact
    if client.preferred_contact_method
      h.content_tag(:span, "(Client prefers to be contacted by #{ContactMethodOption.find(client.preferred_contact_method)})") << phone_span << email_link
    else
      phone_span << email_link
    end
  end

  def phone_span
    h.content_tag(:p, client.phone_number)
  end

  def email_link
    h.content_tag(:p, h.mail_to(client.email, 'Email ', data: { icon: 'envelope' }))
  end

  def new_file_button(label)
    h.link_to label, h.new_client_file_upload_path, class: 'button is-primary'
  end

  def post_file_to
    h.client_file_uploads_path
  end

  def delete_file_button(file)
    h.button_to(I18n.t('clients.buttons.delete'), h.client_file_upload_path(client_id: id, id: file.id), class: 'button is-primary is-small', method: :delete)
  end
end
