class PagesController < ApplicationController
	skip_before_action :authorised, only: [:ruby_index]

	def index
	end
end
