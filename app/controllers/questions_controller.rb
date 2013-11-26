class QuestionsController < ApplicationController
	before_filter :auth, only: [:create]

	def index
		@questions = Question.unanswered(current_user)
		@answer = Answer.new
	end
	def answered
		@questions = Question.answered(current_user) 
		@answer = Answer.new
		render 'index'
	end

	def your_questions
		@questions = current_user.questions.includes(:user)
		@answer = Answer.new
		render 'index'
	end

	def create
		@question = current_user.questions.build(params[:question])
		if @question.save
			track_activity @question
			respond_to do |format|
		        format.js
		    end
		else
			respond_to do |format|
		        format.js
		    end
		end
	end
end
