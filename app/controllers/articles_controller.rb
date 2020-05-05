class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :authorized_for_article_action, only: [:edit, :update, :destroy]
  before_action :authorized, except: [:index, :show]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
     flash[:success] = "Article was updated"
     redirect_to article_path(@article)
    else
     flash[:success] = "Article was not updated"
     render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def authorized_for_article_action
    if @article.user != current_user
      flash[:danger] = "You are not authorized to perform that action"
      redirect_to root_path
    end
  end

end
