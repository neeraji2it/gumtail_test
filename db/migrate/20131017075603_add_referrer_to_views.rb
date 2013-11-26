class AddReferrerToViews < ActiveRecord::Migration
  def change
    add_column :traffics, :referrer, :string
  end
end
