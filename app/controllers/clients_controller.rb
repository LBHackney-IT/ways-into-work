class ClientsController < ApplicationController
  expose :client

  before_action :init_client, only: :create

  def new
    client.build_login
  end

  def create
    if client.save
      client.send_emails
      redirect_to just_registered_path
    else
      render :new
    end
  end

  private

  def init_client
    return if client.postcode.blank?
    if (ward_code = client.hackney_ward_code).present?
      client.auto_assign_advisor(ward_code)
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
      login_attributes: [:email],
      assessment_notes_attributes: %i[
        content
        content_key
      ]
    )
  end
end
