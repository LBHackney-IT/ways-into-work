class ClientsController < ApplicationController
  expose :client

  before_action :init_client, only: :create

  def new
    check_if_enquiry_signup
    client.build_login
  end

  def create
    if client.save
      client.send_emails
      redirect_to just_registered_path
    else
      check_if_enquiry_signup
      render :new
    end
  end

  private

  def init_client
    return if client.postcode.blank?
    if (ward_code = client.hackney_ward_code).present?

      if client.wants_advisor?
        client.auto_assign_advisor(ward_code)
      else # if they do not want an advisor
        opportunity_id = session[:user_login_return_to].match(/\d+/)[0] # Get enquiry ID from url
        opportunity = Opportunity.find(opportunity_id)

        if opportunity.actable_type == 'WorkPlacement'
          client.advisor = Advisor.by_hub_id(6).first # Assign to Employment Pathways Hub
        else
          client.advisor = Advisor.by_hub_id(5).first # or assign to Ghost Jobs Hub for Jobs nad ExternalApprenticeships
        end

      end

      client.login.generate_default_password
    else
      redirect_to(:outside_hackney)
    end
  end

  def client_params # rubocop:disable Metrics/MethodLength
    params.require(:client).permit(
      :title,
      :consent_given,
      :first_name,
      :last_name,
      :phone,
      :preferred_contact_methods,
      :address_line_1,
      :address_line_2,
      :postcode,
      :assigned_supported_employment,
      :wants_advisor,
      login_attributes: [:email],
      assessment_notes_attributes: %i[
        content
        content_key
      ]
    )
  end
end
