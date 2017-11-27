require Rails.root.join('db', 'fixtures', 'seed_helper.rb')
require Rails.root.join('db', 'fixtures', 'client_seeder.rb')

namespace :db do
  desc 'Loads seed data from db/fixtures for the current environment.'
  task seed: :environment do
    
    seeding_files = Dir[Rails.root.join('db', 'fixtures', Rails.env, '*.rb')]
    seeding_files = Dir[Rails.root.join('db', 'fixtures', 'default', '*.rb')] if seeding_files.empty?

    seeding_files.sort.each do |fixture|
      puts "\n== [#{Rails.env}] Seeding from #{File.split(fixture).last} " + ('=' * (60 - (20 + File.split(fixture).last.length + Rails.env.length)))
      load fixture
      puts '=' * 60 + "\n"
    end
  end

  desc 'Create client data'
  task import_clients: :environment do
    filepath = Rails.root.join('lib', 'assets', ENV['filename'])
    puts "importing from #{filepath}"
    ClientSeeder.new(filepath).import
  end
end
