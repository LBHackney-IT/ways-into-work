class Api::V1::ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
      @application = Application.new(application_params)
      if @application.save
        render status: 200, json: @application.to_json
        ApplicationsMailer.confirm_application(@application).deliver_later
        ApplicationsMailer.notify_team_of_new_application(@application).deliver_later
      else
        render status: 500
      end
    end

    def application_params
      params.require(:application).permit(
        :first_name, 
        :last_name, 
        :phone_number, 
        :email, 
        :statement,
        :wordpress_object_id,
        :type
      )
    end

end