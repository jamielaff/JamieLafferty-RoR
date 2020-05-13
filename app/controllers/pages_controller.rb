class PagesController < ApplicationController
	skip_before_action :authorised, only: [:index, :blog_index]

	def index
	end
end
