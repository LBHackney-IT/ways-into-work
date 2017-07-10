class Advisor::MeetingsController < Advisor::BaseController

  def new
    @client = Client.find_by(id: params[:client_id])
    @meeting = @client.meetings.build(advisor_id: current_advisor.id)
    @meeting.agenda = 'initial_assessment' if @client.meetings.count == 0
  end


  def create
    @client = current_advisor.clients.find_by(id: params[:client_id])
    if @meeting = @client.meetings.create(meeting_params)
      redirect_to :advisor_my_clients
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
      :notes,
      :agenda,
      :other_agenda
      )
  end

end
