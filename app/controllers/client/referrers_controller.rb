class Client::ReferrersController < ApplicationController
  expose :referrer
  expose :client, -> { referrer.build_client(login: UserLogin.new) }
  
  before_action only: [:create] do
    check_postcode referrer.client, referrer_params[:client_attributes][:postcode]
  end
  
  def new; end
  
  def create
    if referrer.save
      referrer.client.send_emails
    else
      render :new
    end
  end
  
  private
  
  def referrer_params # rubocop:disable Metrics/MethodLength
    params.require(:referrer).permit(
      :name,
      :organisation,
      :phone,
      :email,
      :reason,
      client_attributes: [
        :title,
        :first_name,
        :last_name,
        :phone,
        :preferred_contact_method,
        :address_line_1,
        :address_line_2,
        :postcode,
        login_attributes: [:email]
      ]
    )
  end
  
end
