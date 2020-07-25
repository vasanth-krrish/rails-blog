class PostsController < ApplicationController

  before_action :find_post, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def profile
    @user = User.find_by(username: params[:id])
    @posts = @user.posts.order("created_at DESC")
  end

  def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
	end

	def update

		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path

	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :user_id)
	end

  def find_post
		@post = Post.find(params[:id])
	end

end
