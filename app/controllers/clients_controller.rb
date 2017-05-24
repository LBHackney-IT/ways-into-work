class ClientsController < ApplicationController

  skip_before_action :register_new_client_to_login

  def new
    @client = Client.new()
  end

  def create
    @client = Client.new(client_params)
    @client.login = current_user_login
    if @client.save
      ServiceManagerMailer.notify_client_signed_up(@client).deliver_now
      redirect_to '/'
    else
      render :new
    end
  end

  private

  def client_params
    params.require(:client).permit(
      :first_name,
      :last_name,
      :phone,
      :address_line_1,
      :address_line_2,
      :address_line_3,
      :postcode,
      :employment_status,
      :benefits_status
      )
  end

end
