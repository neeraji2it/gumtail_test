class UpdateProductViews < ActiveRecord::Migration
  def up
  	execute "update products set views=(select count(*) from traffics where product_id=products.id)"
  end

  def down
  end
end
