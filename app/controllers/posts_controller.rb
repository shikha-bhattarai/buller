class PostsController < ApplicationController
def new  
end

def create
  @post = Post.new(params[:post].permit(:name,:nickname,:email,:imageurl))

  redirect_to :root  
  if params[:imageurl].nil?
    require 'digest/md5'
    email_address = @post.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    @post.imageurl = "http://www.gravatar.com/avatar/#{hash}"    
    @post.save
  end
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
  redirect_to :root
end

private
  def post_params
    params.require(:post).permit(:name, :nickname, :email, :imageurl)
  end  
end