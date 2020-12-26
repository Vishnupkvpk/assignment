class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :authenticate_user!
  # GET /posts
  def index
    @posts = current_user.posts.order(:title).page(params[:page]).per(params[:per_page])
    set_pagination_headers(@posts)
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = current_user.posts.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.permit(:title, :body, :user_id, :avatar)
  end
end
