# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  card_type     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  payment_token :string(255)
#  card_id       :string(255)
#  last_4_digits :string(255)
#  order_id      :integer
#  email         :string(255)
#

class Transaction < ActiveRecord::Base
  attr_accessible :order_id
  belongs_to :order
  #validates_presence_of :last_4_digits

    
end
