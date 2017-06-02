class ClientsController < ApplicationController

  skip_before_action :authenticate_user_login!

  def new
    @client = Client.new()
    @client.build_login
  end

  def create
    @client = Client.new(client_params)
    @client.login.password = Devise.friendly_token.first(20)
    if @client.save
      @client.login.send_reset_password_instructions
      redirect_to '/'
      ServiceManagerMailer.notify_client_signed_up(@client).deliver_later
    else
      render :new
    end
  end

  private

  def client_params
    params.require(:client).permit(
      :title,
      'date_of_birth(1i)',
      'date_of_birth(2i)',
      'date_of_birth(3i)',
      :first_name,
      :last_name,
      :phone,
      :address_line_1,
      :address_line_2,
      :address_line_3,
      :postcode,
      login_attributes: [ :email ]
      )
  end

end
