class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_filter :correct_user, only: [:destroy, :edit, :update]
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	def new
		@micropost = Micropost.new

		respond_to do |format|
      	format.html # new.html.erb
      	format.mobile # new.mobile.erb
      	format.json { render json: @micropost }
    	end
 	end

 	def index
 		@microposts = Micropost.paginate(page: params[:page])
 	end

	def show
		@micropost = Micropost.find(params[:id])
		@user = User.find(@micropost.user_id)
		@comments = @micropost.comments.paginate(page: params[:page])

		respond_to do |format|
			format.html # show.html.erb
			format.mobile # show.mobile.erb
			format.json { render json: @micropost }
		end
	end

	def edit
		@micropost = Micropost.find(params[:id])
	end

	def update
		@micropost = Micropost.find(params[:id])

		respond_to do |format|
			if @micropost.update_attributes(params[:micropost])
				flash[:success] = "Post Updated!"
				format.html { redirect_to(@micropost) }
				format.mobile { redirect_to(@micropost) }
				format.json { head :no_content }
			else
				format.html { render :action => "edit" }
				format.mobile { render :action => "edit" }
				format.json { render :json => @micropost.errors,
							  :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private

		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil?
		end
end