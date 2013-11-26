#creating demo to be used as default during theme customisation, would add products later
namespace :demo do
  desc "Add the demo store"
  task :default_store => :environment do
    Store.create( user_id: 0, store_name: 'demo',theme_name:"custom" )
  end

  desc "Run all  tasks"
  task :all => [:default_store]
end