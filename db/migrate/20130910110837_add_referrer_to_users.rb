class AddReferrerToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:referer,:string
  end
end
