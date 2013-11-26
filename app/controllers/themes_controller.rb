class ThemesController < ApplicationController
	before_filter :auth, except: [:index, :show]

	def index
		@themes = Theme.all
	end

	def new
		@theme = Theme.new
	end

	def create
		@theme = current_user.themes.build(params[:theme])
        if @theme.save
                flash[:success] = "Theme Created"
                redirect_to theme_path(@theme)
        else
                render 'new'
        end
	end
	def show
		@theme = Theme.find(params[:id])
	end

	def edit
		#filter so only owner can edit
		@theme = Theme.find(params[:id])
	end

	def update
		 @theme = Theme.find(params[:id])
		if @theme.update_attributes!(params[:theme])
	      flash[:notice] = 'Updated successfully.'
	      redirect_to theme_path(@theme)
	    else
	      flash[:error] = 'Update failed.'
	      render "edit"
	    end

	end

	def delete
	end

end
