# == Schema Information
#
# Table name: order_events
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  state      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderEvent < ActiveRecord::Base
  attr_accessible :state
  belongs_to :order

  validates_presence_of :order_id
  validates_inclusion_of :state, in: Order::STATES

  def self.with_last_state(state)
  	order("id desc").group("order_id").having(state: state)
  end
end
