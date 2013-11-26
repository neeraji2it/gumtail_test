class Answer < ActiveRecord::Base
	belongs_to :question
  	attr_accessible :body

  	validates :body, presence: true, length: {in: 2..500 }
  	validates_uniqueness_of :question_id
end
