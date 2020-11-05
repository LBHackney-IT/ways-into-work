class Api::V1::ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
      @application = Application.new(application_params)

      if params[:application][:cv].present?
        @file_upload = FileUpload.new(
            attachment: params[:application][:cv],
            uploaded_by: "#{@application.first_name} #{@application.last_name}"
          )

        if @file_upload.save
          @application.file_upload_id = @file_upload.id
        else
          render status: 500
        end
      end

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

    def file_upload_params
      params.require(application[:file_upload]).permit(:application_id, :attachment, :uploaded_by)
    end

end