require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w[development test]))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module WaysIntoWork
  def self.config
    Application.config
  end

  class Application < Rails::Application
    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    config.eager_load = false
    
    # Use controllers to generate 500, 404 etc
    config.exceptions_app = routes

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W[#{config.root}/app/lib/options]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'London'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.secret_key_base = ENV['SECRET_KEY_BASE']
    config.devise_secret_key = ENV['DEVISE_SECRET_KEY_TEST']
    config.devise_pepper = ENV['DEVISE_PEPPER']

    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    config.support_email = ENV.fetch('SUPPORT_EMAIL', 'no-reply@example.com')
    config.learning_team_email = ENV.fetch('LEARNING_TEAM_EMAIL', 'no-reply@example.com')
    config.vacancy_team_email = ENV.fetch('VACANCY_TEAM_EMAIL', 'no-reply@example.com')

    config.action_mailer.preview_path = Rails.root.join('lib', 'mail_previews')

    config.mapbox_access_token = ENV['MAPBOX_ACCESS_TOKEN']

    config.notify_api_key = ENV['NOTIFY_API_KEY']

    if ENV['AWS_SECRET_ACCESS_KEY']
      s3_conf = {
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        bucket: ENV.fetch('S3_BUCKET_NAME')
      }
      config.paperclip_defaults = {
        storage: :s3,
        s3_credentials: s3_conf,
        :s3_permissions => :private,
        bucket: ENV.fetch('S3_BUCKET_NAME'),
        s3_region: ENV['AWS_REGION'],
        s3_protocol: 'https',
        path: 'public/system/:attachment/:id/:style/:basename.:extension',
        url: ':s3_domain_url',
        s3_host_name: "s3-#{ENV['AWS_REGION']}.amazonaws.com"
      }
    else
      config.paperclip_defaults = {
        storage: :filesystem
      }
    end
  end
end
