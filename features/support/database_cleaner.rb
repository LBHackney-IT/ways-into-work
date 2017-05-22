begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  # Use transaction db cleaning strategy for non-js scenarios (faster)
  DatabaseCleaner.strategy = :transaction

  # Ensure the database is clean for each fresh cucumber run (because
  # the db can be left in a dirty state following a debugging session)
  DatabaseCleaner.clean_with :truncation

rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :shared_connection
