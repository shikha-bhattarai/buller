class PostsController < ApplicationController
def new  
end

def create
  @post = Post.new(params[:post].permit(:name,:nickname,:email,:imageurl))
  @post.save
  redirect_to :root  
end
  
def show
  @post = Post.find(params[:id])
  redirect_to :root
end
  
def index
  @posts = Post.all
end
  
def edit
  @post = Post.find(params[:id])
end

def update
  @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:name, :nickname, :email, :imageurl))
      redirect_to @post
    else
      render 'edit'
    end
end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_path
end

private
  def post_params
    params.require(:post).permit(:name, :nickname, :email, :imageurl)
  end  
end