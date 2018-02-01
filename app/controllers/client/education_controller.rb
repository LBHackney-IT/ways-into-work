class Client::EducationController < Client::StepsController
  private

  def step
    :education
  end

  def client_params
    params.require(:client).permit(
      :studying,
      :studying_part_time,
      :past_education,
      :current_education,
      :other_qualification,
      :other_training_course,
      training_courses: []
    )
  end
end
