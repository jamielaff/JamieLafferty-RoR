# frozen_string_literal: true

class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have logged in'
      redirect_to articles_path
    else
      flash.now[:danger] = 'There was something wrong with your login information'
      render 'new'
    end
   end

   def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
   end
end
