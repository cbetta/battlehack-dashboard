namespace :fetch do
  desc  "Fetches All data"
  task :all => :environment do
    Rake::Task["fetch:tweets"].invoke
  end

  desc "Fetches Twitter updates"
  task :tweets => :environment do
    Tweet::Fetcher.new.run
  end
end

