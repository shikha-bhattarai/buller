class SessionsController < ApplicationController
def new
end
def create
  user = Post.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Logged in!"
   else
     flash.keep[:notice]="Invalid email or password"
     render "show"
   end
end
def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
 end
end