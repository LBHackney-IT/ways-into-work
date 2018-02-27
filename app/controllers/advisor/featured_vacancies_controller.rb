class Advisor::FeaturedVacanciesController < ApplicationController
  expose :featured_vacancy
  
  def update
    featured_vacancy.update_attributes(featured_vacancy_params)
  end
  
  private
  
  def featured_vacancy_params
    params.require(:featured_vacancy).permit(:vacancy_id)
  end
  
end
