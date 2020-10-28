class Advisor::ApplicationsController < Advisor::BaseController
  #include ApplicationHelper

  # before_action :set_course_application, only: [:show, :dismiss]
  # before_action :get_intake_and_course, only: [:show]

  def index
    params[:type] ||= "course" # default to course applications

    if params[:type] == "course"
      @applications = CourseApplication.all
      intake_ids = @applications.map{ |application| application.wordpress_object_id }
      response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake?per_page=100&include=#{intake_ids.join(",")}")
      @intakes = response.parsed_response

      @filter_options = @intakes.group_by { |intake| intake["acf"]["parent_course"]["post_title"] }

      @applications_awaiting_review = CourseApplication.awaiting_review
      @applications_reviewed = CourseApplication.reviewed
    elsif params[:type] == "vacancy"
      @applications = VacancyApplication.all
      vacancy_ids = @applications.map{ |application| application.wordpress_object_id }
      response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy?per_page=100&include=#{vacancy_ids.join(",")}")
      @vacancies = response.parsed_response

      @filter_options = @vacancies.group_by { |vacancy| vacancy["title"]["rendered"] }

      @applications_awaiting_review = VacancyApplication.awaiting_review
      @applications_reviewed = VacancyApplication.reviewed
    end

    if params[:course_intake_select].present?
      @applications_awaiting_review = CourseApplication.awaiting_review.where(wordpress_object_id: params[:course_intake_select])
      @applications_reviewed = CourseApplication.reviewed.where(wordpress_object_id: params[:course_intake_select])
    elsif params[:vacancy_select].present?
      @vacancy =  @vacancies.select{|vacancy| vacancy["id"] == params[:vacancy_select].to_i }.try(:first)
      @applications_awaiting_review = VacancyApplication.awaiting_review.where(wordpress_object_id: params[:vacancy_select])
      @applications_reviewed = VacancyApplication.reviewed.where(wordpress_object_id: params[:vacancy_select])
      @total_applications = @applications_awaiting_review.size + @applications_reviewed.size
    end

    respond_to do |format|
      format.html
      format.csv { send_data @course_applications.to_csv(@intakes), filename: "coure-applications-#{Date.today}.csv" }
    end

  end

  def show
  end

  def dismiss
    @course_application.dismissed = true
    @course_application.save
    flash[:success] = "Course application dismissed"
    redirect_to advisor_course_applications_path
  end

  def set_course_application
    @course_application = CourseApplication.find(params[:id])
  end

  def get_intake_and_course
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake/#{@course_application.intake_id}")
    @intake = response.parsed_response if response.parsed_response["id"]
    @course = @intake["acf"]["parent_course"] if @intake
  end

end
