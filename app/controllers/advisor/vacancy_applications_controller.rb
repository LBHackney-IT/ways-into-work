class Advisor::VacancyApplicationsController < Advisor::BaseController
  include VacancyApplicationHelper

  before_action :set_vacancy_application, only: [:show, :dismiss]
  before_action :get_vacancy, only: [:show]

  def index
    @vacancy_applications = VacancyApplication.all

    vacancy_ids = @vacancy_applications.map{ |application| application.vacancy_id }
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy?per_page=100&include=#{vacancy_ids.join(",")}")
    @vacancies = response.parsed_response

    #@filter_options = @intakes.group_by { |intake| intake["acf"]["parent_course"]["post_title"] }

    @vacancy_applications_awaiting_review = VacancyApplication.awaiting_review
    @vacancy_applications_reviewed = VacancyApplication.reviewed

    # if params[:course_intake_select].present?
    #   @vacancy_applications_awaiting_review = VacancyApplication.awaiting_review.where(intake_id: params[:course_intake_select])
    #   @vacancy_applications_reviewed = VacancyApplication.reviewed.where(intake_id: params[:course_intake_select])
    # end

    respond_to do |format|
      format.html
      #format.csv { send_data @vacancy_applications.to_csv(@intakes), filename: "coure-applications-#{Date.today}.csv" }
    end

  end

  def show
    @possible_client = Client.with_email(@vacancy_application.email).first
  end

  def dismiss
    @vacancy_application.dismissed = true
    @vacancy_application.save
    flash[:success] = "Vacancy application dismissed"
    redirect_to advisor_vacancy_applications_path
  end

  def set_vacancy_application
    @vacancy_application = VacancyApplication.find(params[:id])
  end

  def get_vacancy
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy/#{@vacancy_application.vacancy_id}")
    @vacancy = response.parsed_response
  end

end
