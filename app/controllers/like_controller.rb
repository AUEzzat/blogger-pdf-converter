class LikeController < ApplicationController
	def create
	  	@like = @host.likes.new
	  	@like.user_id = current_user.id
	  	@like.save
	  	redirect_to :back
	end

	def destroy
    	@like =like.find(params[:id])
    	@like.destroy
    	redirect_to :back
  	end

end
