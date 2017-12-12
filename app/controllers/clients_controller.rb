class ClientsController < ApplicationController
  expose :client

  def new
    client.build_login
  end

  def create
    if client.assign_area(client_params[:postcode]) == false
      redirect_to(:outside_hackney) && return
    elsif client.save
      client.send_emails
      redirect_to just_registered_path
    else
      render :new
    end
  end

  private

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
