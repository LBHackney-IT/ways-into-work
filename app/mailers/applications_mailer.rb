class ApplicationsMailer < ApplicationMailer

  def confirm_application(application)
    @application = application
    if @application.type == 'CourseApplication'
      @title = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake/#{@application.wordpress_object_id}").parsed_response["acf"]["parent_course"]["post_title"]
    elsif application.type == 'VacancyApplication'
      @title = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy/#{@application.wordpress_object_id}").parsed_response["title"]["rendered"]
    end

    mail(
      to: @application.email,
      subject: I18n.t('course_applications.mail.subject.confirm_application')
    )
  end

  def notify_team_of_new_application(application)
    @application = application

    if @application.type == 'CourseApplication'
      to_email = WaysIntoWork.config.learning_team_email
      @title = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake/#{@application.wordpress_object_id}").parsed_response["acf"]["parent_course"]["post_title"]
    elsif application.type == 'VacancyApplication'
      to_email = WaysIntoWork.config.vacancy_team_email
      @title = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy/#{@application.wordpress_object_id}").parsed_response["title"]["rendered"]
    end

    mail(
      to: to_email,
      subject: I18n.t('course_applications.mail.subject.notify_team_of_new_application')
    )
  end
end
