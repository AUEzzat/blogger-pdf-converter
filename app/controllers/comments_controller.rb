class CommentsController < ApplicationController

  include SessionsHelper

  def create
  	@comment = @host.comments.create!(params.require(:comment).permit!) 
    @comment.user_id = current_user.id
    @comment.save
    if @comment.text.empty?
      @comment.delete
    end
    redirect_to :back
  end

  def destroy
    @comment =Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

end
