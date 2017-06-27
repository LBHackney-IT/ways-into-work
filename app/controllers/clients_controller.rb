class ClientsController < ApplicationController

  before_action :hackney_postcode_eligibility, only: :create

  def new
    @client = Client.new()
    @client.build_login
  end

  def create
    @client = Client.new(client_params)
    @client.login.password = Devise.friendly_token.first(20)
    if @client.save
      @client.login.send_reset_password_instructions
      # flash[:alert] = I18n.t('devise.confirmations.send_instructions')
      redirect_to just_registered_path
      ServiceManagerMailer.notify_client_signed_up(@client).deliver_now
    else
      render :new
    end
  end

  private

  def hackney_postcode_eligibility
    unless client_params[:postcode].present? &&
      # This will be picked up by client validation
      GoingPostal.postcode?(client_params[:postcode], 'GB').present? &&
      HackneyPostcodeValidator.new(client_params[:postcode]).within_hackney?
      redirect_to :outside_hackney
    end
  end

  def client_params
    params.require(:client).permit(
      :title,
      :date_of_birth,
      :first_name,
      :last_name,
      :phone,
      :preferred_contact_method,
      :address_line_1,
      :address_line_2,
      :postcode,
      login_attributes: [ :email ]
      )
  end

end
