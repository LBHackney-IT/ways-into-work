class Advisor::AchievementsController < Advisor::BaseController
  expose :client
  expose :achievement, build_params: -> { { client: client }.merge(achievement_params) }
  expose :achievements, -> { client.achievements }

  def index; end

  def create
    achievement.save
    redirect_to advisor_client_achievements_url(client)
  end

  protected

  def achievement_params
    params.require(:achievement).permit(
      :name,
      :date_achieved,
      :notes
    )
  end
end
