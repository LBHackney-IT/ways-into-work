class Advisor::CourseApplicationsController < Advisor::BaseController

  def index
    @course_applications = CourseApplication.all
  end

  def show
    @course_application = CourseApplication.find(params[:id])
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake")
    @intake = response.parsed_response[0]
  end

end
