if ENV['ERRBIT_API_KEY']
  Airbrake.configure do |config|
    config.project_id  = 1
    config.project_key = ENV['ERRBIT_API_KEY']
    config.host        = 'fg-errors.herokuapp.com'
    config.environment = Rails.env
  end
end
