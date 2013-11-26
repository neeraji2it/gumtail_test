class RemoveFaqsFromStores < ActiveRecord::Migration
  def up
    remove_column :stores,:postage_info
    remove_column :stores,:faqs
  end

  def down
    add_column :stores,:postage_info,:text
    add_column :stores,:faqs,:text
  end
end