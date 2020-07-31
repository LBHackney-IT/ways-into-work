class Advisor::CourseApplicationsController < Advisor::BaseController
  include CourseApplicationHelper

  before_action :set_intakes
  before_action :set_course_application, only: [:show, :update]
  before_action :set_intake_and_course, only: [:show, :update]

  def index
    @course_applications = CourseApplication.all
    if params[:course_intake_select]
      @selected_filter_intake = params[:course_intake_select]
      @course_applications_awaiting_review = CourseApplication.awaiting_review.where(intake_id: params[:course_intake_select])
      @course_applications_reviewed = CourseApplication.reviewed.where(intake_id: params[:course_intake_select])
    else
      @course_applications_awaiting_review = CourseApplication.awaiting_review
      @course_applications_reviewed = CourseApplication.reviewed
    end
  end

  def show
  end

  def update

    if @course_application.update_attributes(course_application_params)
      flash[:success] = "Enquiry review updated"
      #redirect_to session[:return_to]
      render 'show'
    else
      render 'index'
    end
  end

  def set_intakes
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake")
    @intakes = response.parsed_response
  end

  def set_course_application
    @course_application = CourseApplication.find(params[:id])
  end

  def set_intake_and_course
    @intake = intake(@intakes, @course_application.intake_id)
    @course = @intake["acf"]["parent_course"]
  end

  def course_application_params
    params.require(:course_application).permit(:first_name, :last_name, :phone_number, :email, :intake_id, :status, :feedback)
  end
end
