class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create 
		@comment = Comment.new(comment_params)
		@comment_chef = current_chef
		if @comment.save
			redirect_to recipe_path(@recipe)
		else
			render :new
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:description)
	end
end

