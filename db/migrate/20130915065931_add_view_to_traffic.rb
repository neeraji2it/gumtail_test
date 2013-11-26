class AddViewToTraffic < ActiveRecord::Migration
  def change
  	add_column :traffics,:view,:integer,:default => 1
  end
end
