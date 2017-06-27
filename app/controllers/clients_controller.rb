class ClientsController < ApplicationController

  before_action :lookup_hub, only: :create

  def new
    @client = Client.new()
    @client.build_login
  end

  def create
    if @client.login.generate_default_password && @client.save
      @client.login.send_reset_password_instructions
      flash[:alert] = I18n.t('devise.confirmations.send_instructions')
      redirect_to just_registered_path
      ServiceManagerMailer.notify_client_signed_up(@client).deliver_now
    else
      render :new
    end
  end

  private

  def lookup_hub
    @mapit_ward_finder = HackneyPostcodeValidator.new(client_params[:postcode])
    if @mapit_ward_finder.within_hackney?
      @client = Client.new(client_params)
      @client.assign_hub(@mapit_ward_finder.ward_code)
    else
      redirect_to :outside_hackney
    end
  end

  def client_params
    params.require(:client).permit(
      :title,
      'date_of_birth(1i)',
      'date_of_birth(2i)',
      'date_of_birth(3i)',
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
