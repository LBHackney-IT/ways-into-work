class ClientsController < ApplicationController

  def new
    @client = Client.new()
  end

  def create
    @client = Client.new(client_params)
    @client.login = current_user_login
    if @client.save
      ServiceManagerMailer.notify_client_signed_up(@client).deliver_now
      redirect_to client_dashboard_path
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
      :postcode
      )
  end

end
