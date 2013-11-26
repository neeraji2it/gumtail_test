class UpdateStoreViews < ActiveRecord::Migration
  def up
  	execute "update stores set views=(select count(*) from traffics WHERE store_id=stores.id)"
  	execute "update stores set unique_views=(select count(*) from traffics WHERE store_id=stores.id GROUP BY ip_address)"
  end

  def down
  end
end
