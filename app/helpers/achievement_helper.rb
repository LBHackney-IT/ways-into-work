module AchievementHelper
  def first_or_subsequent(count)
    count == 1 ? 'first' : 'subsequent'
  end
end
