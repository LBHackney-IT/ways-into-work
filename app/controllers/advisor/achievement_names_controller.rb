class Advisor::AchievementNamesController < ApplicationController
  respond_to :json

  def index
    render json: search_names
  end

  private

  def search_names
    if params[:term].blank? || params[:term].length < 2
      AchievementOption.all.collect(&:name)
    else
      Achievement.where('name like ?', "%#{params[:term]}%").limit(8)
    end
  end
end
