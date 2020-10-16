class Api::V1::VacancyApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
      @vacancy_application = VacancyApplication.new(vacancy_application_params)
      if @vacancy_application.save
        render status: 200, json: @vacancy_application.to_json
        CourseApplicationMailer.confirm_application(@vacancy_application).deliver_later
        CourseApplicationMailer.notify_team_of_new_application(@vacancy_application).deliver_later
      else
        render status: 500
      end
    end

    def vacancy_application_params
      params.require(:vacancy_application).permit(
        :first_name, 
        :last_name, 
        :phone_number, 
        :email, 
        :statement, 
        :vacancy_id
      )
    end

end

