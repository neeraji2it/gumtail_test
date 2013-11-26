# == Schema Information
#
# Table name: notifications
#
#  id                             :integer          not null, primary key
#  user_id                        :integer
#  news                           :boolean
#  tips                           :boolean
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  email_subscribe_to_you         :boolean          default(TRUE)
#  email_comments_on_your_story   :boolean          default(TRUE)
#  email_product_is_featured      :boolean          default(TRUE)
#  email_recommends_your_product  :boolean          default(TRUE)
#  email_purchase_your_product    :boolean          default(TRUE)
#  email_request_sold_out_product :boolean          default(TRUE)
#

class Notification < ActiveRecord::Base
  attr_accessible :email_subscribe_to_you,:email_comments_on_your_story,:email_product_is_featured,:email_recommends_your_product,:email_purchase_your_product,
  :email_request_sold_out_product, :news,:tips
  belongs_to :user
end
