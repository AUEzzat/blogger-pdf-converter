class Posts::LikeController < LikesController
  before_action :set_host

  private

    def set_host
      @host = Post.friendly.find(params[:post_id])
    end
end