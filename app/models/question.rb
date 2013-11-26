class Question < ActiveRecord::Base
	belongs_to :user
    has_one :answer
    attr_accessible  :body, :questioned_id
    validates :body, presence: true, length: { in: 2..250 }
    validates :answered, inclusion: { in: [true, false ]}
    default_scope order('created_at desc')

    def self.unanswered(user)
    	where(questioned_id: user.id, answered: false)
    end

    def self.answered(user)
    	where(questioned_id: user.id, answered: true)
    end

    def set_answered
        self.update_attribute(:answered, true)
    end
end
