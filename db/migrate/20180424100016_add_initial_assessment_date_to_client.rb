class AddInitialAssessmentDateToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :initial_assessment_date, :date
    
    Client.all.each do |c|
      c.initial_assessment_date = c.meetings.where(agenda: 'initial_assessment', client_attended: true).order(created_at: :desc).limit(1).pluck(:start_datetime).first
      c.save
    end
  end
end
