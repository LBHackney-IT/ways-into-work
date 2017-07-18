class ClientDecorator < Draper::Decorator

  delegate_all

  decorates :client

  def client_profile_header
    'Your Profile'
  end

  def decorate_name
    standard_wrapper('Name:', client.name)
  end

  def decorate_date_registered
    standard_wrapper('Date regstiered:', client.created_at.to_formatted_s(:long))
  end

  def decorate_email
    standard_wrapper('Email account:', client.email)
  end

  def decorate_phone
    standard_wrapper("Phone number:", client.phone_number)
  end

  def decorate_address
    standard_wrapper("Address:", client.address_to_s)
  end

  def decorate_age
    standard_wrapper("Age:", client.age_in_years.to_s)
  end

  def decorate_personal_traits
    standard_wrapper("Strengths:", PersonalTraitOption.display(client.personal_traits))
  end

  def decorate_other_personal_trait
    standard_wrapper("Other:", client.other_personal_trait)
  end

  def decorate_objectives
    standard_wrapper("Objectives:", ObjectiveOption.display(client.objectives))
  end

  def decorate_other_objective
    standard_wrapper("Other:", client.other_objective)
  end

  def decorate_support_priorities
    standard_wrapper("Support priorities:", client.support_priorities)
  end

  def decorate_types_of_work
    standard_wrapper("Industry preference:", client.types_of_work)
  end

  def decorate_barriers
    standard_wrapper("Barriers:", client.barriers)
  end

  def decorate_rag_status
    standard_wrapper("Status:", client.rag_status)
  end

  def decorate_studying
    standard_wrapper("Currently studying:", value_from(client.studying))
  end

  def decorate_current_education
    standard_wrapper("Current education course title:", client.current_education )
  end

  def decorate_past_education
    standard_wrapper("Past education:", client.past_education)
  end

  def decorate_currently_employed
    standard_wrapper("Currently employed:", value_from(client.employed))
  end

  def decorate_job_title
    standard_wrapper("Job title:", client.job_title)
  end

  def decorate_hours_per_week
    standard_wrapper("Hours per week:", client.working_hours_per_week)
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
    h.content_tag(:p, h.mail_to(client.email, 'Email ', data: {'icon': 'envelope'}))
  end

  def new_file_button
    h.link_to I18n.t('clients.buttons.manage_cvs'), h.new_client_file_upload_path, class: "button is-primary is-small"
  end

  def post_file_to
    h.client_file_uploads_path
  end

  def delete_file_button(file)
    h.button_to(I18n.t('clients.buttons.delete'), h.client_file_upload_path(client_id: id, id: file.id), class: 'button is-primary is-small', method: :delete)
  end

  def value_from(boolean)
    case boolean
    when true
      'Yes'
    when false
      'No'
    else
      'Unknown'
    end
  end

  def standard_wrapper(label, value)
    if value.present?
      h.content_tag(:p, '') do
        h.content_tag(:label, label, class: 'label') <<
        value
      end
    end
  end

end
