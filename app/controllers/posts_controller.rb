class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :addtag, :addtagpost, :removetag]
  before_action :check_author, only: [:edit, :update, :destroy, :addtagpost, :removetag, :addtag]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @user = current_user
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(@post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def addtagpost
    if ( !addtag_params[:tag_id].blank? )
      tagID = addtag_params[:tag_id]
      tempTag = Tag.find(tagID)
      @post.tags << tempTag
      logger.debug("add tag params " + tempTag.name)
      redirect_to @post, notice: 'Successfully added tag'
    else
      logger.debug("tag null return")
      redirect_to @post, notice: 'Invalid tag id'
    end
  end

  def removetag
    targetTag = @post.tags.find(removetag_params[:tagid])
    if ( targetTag.nil? )
      logger.debug('Tag not found')
      redirect_to @post, notice: 'Tag not found'
    else
      logger.debug('Tag found : ' + targetTag.name)
      @post.tags.delete(targetTag)
      redirect_to @post, notice: 'Tag is removed'
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    if ( @post.user_id != current_user.id )
      redirect_to posts_path, notice: 'Undifined user, post was not successfully created.'
    else
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    tempPost = Post.new(post_params)
    if ( tempPost.user_id != current_user.id )
      redirect_to posts_path, notice: 'Undefined user, post was not successfully edited'
    else
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
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end

    def addtag_params
      params.permit(:tag_id)
    end

    def removetag_params
      params.permit(:id, :tagid)
    end

    def check_author
      if ( @post.user_id != current_user.id )
        redirect_to posts_path, notice: 'You are not author of this post' and return
      end
    end
end
