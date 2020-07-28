class CourseApplicationMailer < ApplicationMailer
  def confirm_application(course_application)
    @course_application = course_application
    @intake = @course_application.intake

    mail(
      to: @course_application.email,
      subject: I18n.t('course_applications.mail.subject.confirm_application')
    )
  end
end
