class PostsController < ApplicationController
  include PostsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy, :make_like, :make_unlike]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    if @post.save
      redirect_to @post, notice: "#{@post.title} was successfully uploaded."
      pdf=File.open("#{Rails.root}/public"+"#{@post.slide}", 'rb').read
      pdf=Magick::Image::from_blob(pdf) do
        self.format = 'PDF'
        self.quality = 100
        self.density = 200
      end
      i=0
      pdf.each do |page|
        i=i+1
        page.format='JPG'
        page.to_blob
        show_path="#{@post.slide}"+sprintf("%02d", i).to_s+".jpg"
        save_path="#{Rails.root}/public"+show_path
        jpg=page.write(save_path)
        @image = @post.images.new(number: i, preview: show_path)
        @image.save
      end
     else
      render :new
     end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    FileUtils.rm_rf("public/uploads/post/slide/#{@post.id}")
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def make_like
    like = @post.likes.new(user_id: current_user.id)
    like.save
    redirect_to(:back)
  end

  def make_unlike
    like = @post.likes.where(user_id: current_user.id).last
    if like==nil or like==[] then redirect_to :back end
    like.delete
    redirect_to(:back)
  end

  def index_images
    images_path=Array.new
    images_names=Dir.entries("public/uploads/post/slide/#{@post.id}").select {|f| !File.directory? f}
    images_names.sort!
    images_names[1..-1].each do |imageName|
      images_path.push("/uploads/post/slide/#{@post.id}/#{imageName}")
    end
    return images_path
  end

  helper_method :index_images 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :slide)
    end

end
