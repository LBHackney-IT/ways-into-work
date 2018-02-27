class Advisor::VacanciesController < ApplicationController
  before_action :check_permissions!
  expose :vacancy
  
  def index; end
  
  def new; end
  
  def create
    if vacancy.update_attributes(vacancy_params)
      redirect_to advisor_vacancies_path
    else
      render :new
    end
  end
  
  def update; end
  
  private

  def check_permissions!
    not_authorised unless current_advisor.employer_engagement?
  end
  
  def vacancy_params
    params.require(:vacancy).permit(:title, :vacancy_type, :salary, :description)
  end
  
end
