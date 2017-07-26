require "#{Rails.root}/db/fixtures/seed_helper.rb"
require "#{Rails.root}/lib/seeders/client_seeder.rb"

namespace :db do

  desc "Loads seed data from db/fixtures for the current environment."
  task :seed => :environment do
    # Dir[File.join(Rails.root, fixture_path, Rails.env, '*.rb')].sort.each { |fixture|
    Dir[File.join(Rails.root, "db/fixtures/default", '*.rb')].sort.each { |fixture|
      puts "\n== [#{Rails.env}] Seeding from #{File.split(fixture).last} " + ("=" * (60 - (20 + File.split(fixture).last.length + Rails.env.length)))
      load fixture
      puts "=" * 60 + "\n"
    }
  end

  desc "Create client data"
  task :import_clients => :environment do
    filepath = "#{Rails.root}/lib/assets/Woodberry_Down_Active_Caseload.csv"
    puts "importing from #{filepath}"
    ClientSeeder.new(filepath).import
  end

end
