class PostsController < ApplicationController
def new  
  @post = Post.new
end

def create
  @post = Post.new(params[:post].permit(:name,:nickname,:email,:imageurl,:password,:password_confirmation))
  if params[:imageurl].nil?
    require 'digest/md5'
    email_address = @post.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    @post.imageurl = "http://www.gravatar.com/avatar/#{hash}" 
    if @post.save
      flash.keep[:notice]="Your profile is sucessfully created!"
      redirect_to :root
    else
      render 'new'
    end
  end
  @post.save
  
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
  @post.update(params[:post].permit(:name, :nickname, :email,:imageurl,:password,:password_confirmation))
    if params[:imageurl].nil?
    require 'digest/md5'
    email_address = @post.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    @post.imageurl = "http://www.gravatar.com/avatar/#{hash}" 
end
  if @post.save
   flash.keep[:notice]="Your profile is updated sucessfully!"
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
    params.require(:post).permit(:name, :nickname, :email, :imageurl,:password,:password_confirmation)
  end  
end