class CourseApplicationMailer < ApplicationMailer
  include CourseApplicationHelper

  def confirm_application(course_application)
    @course_application = course_application

    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake")
    @intakes = response.parsed_response

    @intake = intake(@intakes, @course_application.intake_id)

    mail(
      to: @course_application.email,
      subject: I18n.t('course_applications.mail.subject.confirm_application')
    )
  end

  def course_application_accepted(course_application)
    @course_application = course_application

    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake")
    @intakes = response.parsed_response

    @intake = intake(@intakes, @course_application.intake_id)

    mail(
      to: @course_application.email,
      subject: I18n.t('course_applications.mail.subject.course_application_accepted')
    )
  end

  def course_application_unsuccessful(course_application)
    @course_application = course_application

    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake")
    @intakes = response.parsed_response

    @intake = intake(@intakes, @course_application.intake_id)

    mail(
      to: @course_application.email,
      subject: I18n.t('course_applications.mail.subject.course_application_unsuccessful')
    )
  end
end
