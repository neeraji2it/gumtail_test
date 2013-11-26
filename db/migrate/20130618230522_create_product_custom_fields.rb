class CreateProductCustomFields < ActiveRecord::Migration
  def change
    create_table :product_custom_fields do |t|
    	t.string :name
    	t.integer :product_id
    	t.boolean :required

      t.timestamps
    end
  end
end
