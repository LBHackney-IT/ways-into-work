WaysIntoWork::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = 'public, max-age=3600'

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # this doesn't actually send any SMS messages so safe to check in
  config.notify_api_key = 'testhackneyworks-4dc22113-fc51-41ec-b73d-d25155d82fff-1a0de55f-2c5b-491d-99ae-ebe78caeb88f'
end

# Always raise I18n exceptions in test environment
class I18nTestExceptionHandler < I18n::ExceptionHandler
  def self.call(exception, locale, key, options)
    return super(exception, locale, key, options) unless exception.respond_to?(:to_exception)
    raise exception.to_exception
  end
end
I18n.exception_handler = I18nTestExceptionHandler
