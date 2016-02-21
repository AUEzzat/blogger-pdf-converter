class Images::LikeController < LikesController
  before_action :set_host

  private

    def set_host
      post = Post.friendly.find(params[:post_id])
      @host = post.images.friendly.find(params[:image_id])
    end
end