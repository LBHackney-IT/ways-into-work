class Client::ReferrersController < ApplicationController
  expose :referrer
  expose :client, -> { referrer.client || referrer.build_client(login: UserLogin.new) }

  before_action :init_client, only: :create

  def new; end

  def create
    if referrer.save
      referrer.client.send_emails
      referrer.send_confirmation_email
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
      redirect_to(:referrer_outside_hackney)
    end
  end

  def referrer_params # rubocop:disable Metrics/MethodLength
    params.require(:referrer).permit(
      :name,
      :organisation,
      :phone,
      :email,
      :reason,
      client_attributes: [
        :consent_given,
        :title,
        :first_name,
        :last_name,
        :phone,
        :preferred_contact_methods,
        :address_line_1,
        :address_line_2,
        :postcode,
        :assigned_supported_employment,
        login_attributes: [:email]
      ]
    )
  end
end
