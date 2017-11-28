#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

WaysIntoWork::Application.load_tasks

begin
  require 'rspec/core/rake_task'
  require 'coveralls/rake/task'
  
  Coveralls::RakeTask.new
  RSpec::Core::RakeTask.new(:spec)
  
  task(:default).clear
  task default: [:cucumber, :spec, 'coveralls:push']
rescue LoadError
  # no rspec available
end
