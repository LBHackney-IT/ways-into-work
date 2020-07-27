class Advisor::CourseApplicationsController < Advisor::BaseController

  def index
    @course_applications = CourseApplication.all
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake")
    @intakes = response.parsed_response
  end

  def show
    @course_application = CourseApplication.find(params[:id])
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake")
    @intake = response.parsed_response[0]
    @course = @intake["acf"]["parent_course"]
  end

  def update
    @course_application = CourseApplication.find(params[:id])
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake")
    @intake = response.parsed_response[0]
    @course = @intake["acf"]["parent_course"]
    if @course_application.update_attributes(course_application_params)
      flash[:success] = "Enquiry review updated"
      #redirect_to session[:return_to]
      render 'show'
    else
      render 'show'
    end
  end

  def course_application_params
    params.require(:course_application).permit(:first_name, :last_name, :phone_number, :email, :intake_id, :status)
  end
end
