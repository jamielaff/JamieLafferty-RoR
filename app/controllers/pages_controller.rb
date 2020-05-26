class PagesController < ApplicationController
	skip_before_action :authorised, only: [:index]

	def index
	  @articles = Article.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
	end
end
