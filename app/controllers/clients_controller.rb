class ClientsController < ApplicationController
  expose :client

  before_action :init_client, only: :create

  def new
    check_if_enquiry_signup
    client.build_login
  end

  def create
    check_if_enquiry_signup
    if client.save
      client.send_emails
      if @registering_to_enquire
        sign_in(client.login, scope: :user_login)
        redirect_to session[:user_login_return_to]
      else
        redirect_to just_registered_path
      end
    else
      render :new
    end
  end

  private

  def init_client
    return if client.postcode.blank?
    puts "Does the console work"
    Rails.logger.info "Postcode is #{client.hackney_ward_code}"
    if (ward_code = client.hackney_ward_code).present?
      Rails.logger.info "Postcode is valid"
      if client.wants_advisor? # default is true, only get option to not have advisor if registering through enquiry.
        client.auto_assign_advisor(ward_code)
      else # if they do not want an advisor
        opportunity_id = session[:user_login_return_to].match(/\d+/)[0] # Get opportunity (that enquiring for) ID from url
        opportunity = Opportunity.find(opportunity_id)

        if opportunity.actable_type == 'WorkPlacement'
          client.advisor = Hub.find(6).manager # Assign to Employment Pathways Hub
        else
          client.advisor = Hub.find(5).manager # or assign to Ghost Jobs Hub for Jobs and ExternalApprenticeships
        end

      end

      client.login.generate_default_password
    else
      Rails.logger.info "Doing the redirect"
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
      :wants_advisor,
      login_attributes: [:email],
      assessment_notes_attributes: %i[
        content
        content_key
      ]
    )
  end
end
