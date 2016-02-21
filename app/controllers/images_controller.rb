class ImagesController < ApplicationController
  before_action :set_post
  before_action :set_image, only: [:show, :edit, :update, :destroy, :make_like, :make_unlike]

  # GET /images
  # GET /images.json
  def index
    @images = @post.images.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = @post.images.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = @post.images.new(image_params)

    respond_to do |format|
      if @image.save
        redirect_to @post.image
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_like
    like = @image.likes.new(user_id: current_user.id)
    like.save
    redirect_to(:back)
  end

  def make_unlike
    like = @image.likes.where(user_id: current_user.id).last
    if like==nil or like==[] then redirect_to :back end
    like.delete
    redirect_to(:back)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = @post.images.friendly.find(params[:id])
    end
    def set_post
      @post = Post.friendly.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:number, :preview)
    end
end
