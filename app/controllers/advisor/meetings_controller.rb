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
      redirect_to advisor_client_meetings_path(client_id: meeting.client_id)
    else
      build_errors
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

  def meeting_params # rubocop:disable Metrics/MethodLength
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
      @date = attrs.delete('start_date').try(:to_date)
      @time = attrs.delete('start_time').try(:to_time)
      attrs[:start_datetime] = build_datetime(@date, @time)
    end
  end
  
  def build_datetime(date, time)
    if time.present? && date.present?
      Time.zone.local(date.year, date.month, date.day, time.hour, time.min)
    else
      @date_error = time.present? ? 'date' : 'time'
      nil
    end
  end
  
  def build_errors
    return unless @date_error
    meeting.errors.messages.delete(:start_datetime)
    meeting.errors.messages[@date_error.to_sym] = ["can't be blank"]
  end
  
end
