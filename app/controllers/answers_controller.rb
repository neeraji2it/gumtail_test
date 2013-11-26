class AnswersController < ApplicationController
	before_filter :auth, only: [:create]
	def new 
	end

	def create
		@question = Question.find(params[:question_id])
		#validation for question.questioned_id must equal current_user.id
		@answer = @question.build_answer(params[:answer])
		@answer.user_id = current_user.id
		if @answer.save 
			track_activity @answer
			@question.set_answered
		end
		respond_to do |format|
	      format.js
	    end
	end
end
