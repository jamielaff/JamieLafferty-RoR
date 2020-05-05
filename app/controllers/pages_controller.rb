class PagesController < ApplicationController
	skip_before_action :authorised, only: [:index]

	def index
	end
end
