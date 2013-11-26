# == Schema Information
#
# Table name: themes
#
#  id            :integer          not null, primary key
#  theme_content :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Theme < ActiveRecord::Base
	serialize :custom_appearance, ActiveRecord::Coders::Hstore
	attr_accessible :theme_name, :theme_content
	belongs_to :user
	validates :theme_name, presence: true
	validates :theme_content, presence: true

   %w[link_color bg_color title_color].each do |key|
	    attr_accessible key
	    
	    define_method(key) do
	      custom_appearance && custom_appearance[key]
	    end
	  
	    define_method("#{key}=") do |value|
	      self.custom_appearance = (custom_appearance || {}).merge(key => value)
	    end
  	end
end
