class Advisor::MeetingsController < Advisor::BaseController

  expose :client
  expose :meeting
  expose :new_meeting, -> { client.meetings.build(advisor_id: current_advisor.id) }

  def index
  end

  def new
    new_meeting.agenda = 'initial_assessment' if client.meetings.empty?
  end

  def edit
  end


  def create
    if meeting.save
      flash[:success] = "Meeting saved"
      redirect_to :advisor_my_clients
    else
      render :new
    end
  end

  def update
    if meeting.update(meeting_params)
      flash[:success] = "Meeting updated"
      redirect_to advisor_client_meetings_path(client_id: meeting.client_id)
    else
      render :new
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(
      'start_datetime(1i)',
      'start_datetime(2i)',
      'start_datetime(3i)',
      'start_datetime(4i)',
      'start_datetime(5i)',
      :advisor_id,
      :client_id,
      :notes,
      :agenda,
      :other_agenda)
  end

end
