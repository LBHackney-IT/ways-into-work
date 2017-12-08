class ClientsController < ApplicationController
  expose :client

  def new
    client.build_login
  end

  def create
    if client.assign_area(client_params[:postcode]) == false
      redirect_to(:outside_hackney) && return
    elsif client.save
      setup_client(client)
      redirect_to just_registered_path
    else
      render :new
    end
  end

  private
  
  def setup_client(client)
    client.login.send_reset_password_instructions
    AdvisorMailer.notify_client_signed_up(client).deliver_now
  end

  def client_params # rubocop:disable Metrics/MethodLength
    params.require(:client).permit(
      :title,
      :first_name,
      :last_name,
      :phone,
      :preferred_contact_method,
      :address_line_1,
      :address_line_2,
      :postcode,
      login_attributes: [:email]
    )
  end
end
