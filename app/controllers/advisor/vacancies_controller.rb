class Advisor::VacanciesController < ApplicationController
  before_action :check_permissions!
  expose :vacancies, -> { Vacancy.all }
  expose :vacancy
  
  before_action :load_featured_vacancies, only: %i[index]
  
  def index; end
  
  def new; end
  
  def edit; end
  
  def create
    if vacancy.update_attributes(vacancy_params)
      redirect_to advisor_vacancies_path
    else
      render :new
    end
  end
  
  def update
    if vacancy.update_attributes(vacancy_params)
      redirect_to advisor_vacancies_path
    else
      render :edit
    end
  end
  
  def destroy
    vacancy.destroy
    redirect_to advisor_vacancies_path
  end
  
  private

  def check_permissions!
    not_authorised unless current_advisor.employer_engagement?
  end
  
  def vacancy_params
    params.require(:vacancy).permit(:title, :vacancy_type, :salary, :description)
  end
  
  def load_featured_vacancies
    @featured_vacancies = FeaturedVacancy.all
  end
  
end
