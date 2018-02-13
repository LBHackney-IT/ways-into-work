class Advisor::TaskTitlesController < ApplicationController
  respond_to :json

  def index
    render json: search_names
  end

  private

  def search_names
    names = AchievementOption.all.collect(&:name)
    term = params[:term].downcase
    return names if term.blank? || term.length < 2
    names.select do |name|
      name.downcase.match(term)
    end
  end
end
