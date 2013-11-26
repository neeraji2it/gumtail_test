class FileHandlersController < ApplicationController
	def index
	end
	def new
	end
	def create
		@files = current_user.files.create(params[:file_handler])
	end
	def edit	
	end
	def update
	end
	
	def destroy
	  @file = FileHandler.find(params[:id])  
	  @file.destroy  
	  respond_to do |format|  
	    format.js   { render :nothing => true }  
	  end 
	end
end
