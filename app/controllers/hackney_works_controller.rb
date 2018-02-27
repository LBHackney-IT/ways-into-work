class HackneyWorksController < ApplicationController
  def show
    @featured_vacancies = FeaturedVacancy.all
  end
end
