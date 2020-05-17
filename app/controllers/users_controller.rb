# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorised, only: [:index, :new, :create, :show]

  before_action :authorised_for_user_actions, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the my test blog, #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
     end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:success] = "User was deleted"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def authorised_for_user_actions
    unless @user == current_user
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end
end
