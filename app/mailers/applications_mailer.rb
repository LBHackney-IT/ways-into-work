class ApplicationsMailer < ApplicationMailer

  def confirm_application(application)
    @application = application
    if @application.type == 'CourseApplication'
      set_intake_title(application)
    elsif application.type == 'VacancyApplication'
      set_vacancy_title(@application)
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

      set_intake_title(@application)

    elsif application.type == 'VacancyApplication'
      to_email = WaysIntoWork.config.vacancy_team_email

      set_vacancy_title(@application)

    end

    mail(
      to: to_email,
      subject: I18n.t('course_applications.mail.subject.notify_team_of_new_application')
    )
  end

  def set_intake_title application
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/intake/#{application.wordpress_object_id}")

    if response.parsed_response["id"]
      @intake = response.parsed_response
      @title = @intake["acf"]["parent_course"]["post_title"]
    else
      @title = 'intake not found'
    end
  end

  def set_vacancy_title application
    response = HTTParty.get("#{ENV['WORDPRESS_DOMAIN']}/wp-json/wp/v2/vacancy/#{application.wordpress_object_id}")
    if response.parsed_response["id"]
      @vacancy = response.parsed_response
      @title = @vacancy["title"]["rendered"]
    else
      @title = 'vacancy not found'
    end
  end
end
