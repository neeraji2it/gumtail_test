# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  created_at :datetime
#  product_id :integer

#class ChangesToTaggings < ActiveRecord::Migration
#  def up
#  	add_column :taggings,:product_id,:integer
#  	remove_column :taggings, :taggable_id
#  	remove_column :taggings, :taggable_type
#  	remove_column :taggings, :tagger_id
#  	remove_column :taggings, :tagger_type
#  	remove_column :taggings, :context
#  end

#  def down
#  	remove_column :taggings,:product_id
#  	add_column :taggings, :taggable_id,:integer
#  	add_column :taggings, :taggable_type,:string
#  	add_column :taggings, :tagger_id,:integer
#  	add_column :taggings, :tagger_type,:string
#  	add_column :taggings, :context,:string
#  end
#end


class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :product
  # attr_accessible :title, :body
end
