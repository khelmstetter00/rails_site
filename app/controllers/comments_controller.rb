class CommentsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comment = Comment.new(:content => params[:comment][:content])
		@comment.micropost_id = @micropost.id
		@comment.user_id = current_user.id
		@comment.save
		respond_to do |format|
			format.html { redirect_to micropost_path(@micropost) }
			format.js
		end
	end

	def destroy
		@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.find(params[:id])
		@comment.destroy
		redirect_to micropost_path(@micropost)
	end


	private

		def correct_user
			@comment = current_user.comments.find_by_id(params[:id])
			redirect_to root_url if @comment.nil?
		end
end
