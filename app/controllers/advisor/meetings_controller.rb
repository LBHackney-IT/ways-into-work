class Advisor::MeetingsController < Advisor::BaseController
  expose :client
  expose :meeting

  def index; end

  def new
    meeting.agenda = 'initial_assessment' if client.meetings.empty?
    meeting.advisor_id = current_advisor.id
    meeting.client_id = params[:client_id]
  end

  def edit; end

  def create
    if meeting.save
      flash[:success] = 'Meeting saved'
      redirect_to :advisor_my_clients
    else
      render :new
    end
  end

  def update
    if meeting.update(meeting_params)
      flash[:success] = 'Meeting updated'
      redirect_to advisor_client_meetings_path(client_id: meeting.client_id)
    else
      render :edit
    end
  end

  private

  def meeting_params # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @parsed_params ||= params.require(:meeting).permit(
      :start_date,
      :start_time,
      :advisor_id,
      :client_id,
      :notes,
      :agenda,
      :other_agenda,
      :client_attended
    ).tap do |attrs|
      date = attrs.delete('start_date').try(:to_date)
      time = attrs.delete('start_time').try(:to_time)
      attrs[:start_datetime] = if time.present? && date.present?
                                 DateTime.new(date.year, date.month, date.day, time.hour, time.min).utc
                               else
                                 '' # Ensure error is thrown
                               end
    end
  end
end
