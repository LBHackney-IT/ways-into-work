class Advisor::CourseApplicationsController < Advisor::BaseController
  include CourseApplicationHelper

  before_action :set_course_application, only: [:show, :dismiss]
  before_action :get_intake_and_course, only: [:show]

  def index
    @course_applications = CourseApplication.all

    intake_ids = @course_applications.map{ |application| application.intake_id }
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake?per_page=100&include=#{intake_ids.join(",")}")
    @intakes = response.parsed_response

    @filter_options = @intakes.group_by { |intake| intake["acf"]["parent_course"]["post_title"] }

    @course_applications_awaiting_review = CourseApplication.awaiting_review
    @course_applications_reviewed = CourseApplication.reviewed

    if params[:course_intake_select].present?
      @course_applications_awaiting_review = CourseApplication.awaiting_review.where(intake_id: params[:course_intake_select])
      @course_applications_reviewed = CourseApplication.reviewed.where(intake_id: params[:course_intake_select])
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
