# frozen_string_literal: true

class SessionsController < ApplicationController

  skip_before_action :authorised, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.is_admin
        flash[:danger] = "You have logged in as a site admin, use with care"
      else
        flash[:success] = "You have logged in"
      end
      redirect_to articles_path
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
   end

   def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
   end
end
