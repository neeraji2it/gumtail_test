# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :products, through: :taggings
  #scope :trending, lambda { |num = nil| where("started_trending > ?", 1.day.ago).order("mention_weight desc").limit(num) }
  #before_create :set_trend_ending
  #TRENDING_PERIOD = 1.week
end
