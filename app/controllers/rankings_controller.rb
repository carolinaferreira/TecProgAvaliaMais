# Class: rankings_controller.rb.
# Purpose: This class controls the ranking of companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class RankingsController < ApplicationController

	# Name: response_time_all.
  	# Objective: this method returns all companies ordered by response_time attribute.
  	# Parameters: none.
  	# Return: return all segments, companies for first page and all companies ordered by response time.

	def response_time_all

		@segments = Segment.all.order(:name)
		@companies_unpaginated = Company.where('response_time is not null').order(:response_time)
		@companies = @companies_unpaginated.paginate(:page => params[:page], :per_page => 15)

		return @segments
		return @companies_unpaginated
		return @companies

	end

	# Name: grade_all.
  	# Objective: this method returns all companies ordered by grade attribute.
  	# Parameters: none.
  	# Return: return all segments, companies for first page and all companies ordered by grade.

	def grade_all

		@segments = Segment.all.order(:name)
		@companies_unpaginated = Company.all.order('rate DESC')
		@companies = Company.all.order('rate DESC').paginate(:page => params[:page], :per_page => 15)

		return @segments
		return @companies_unpaginated
		return @companies
		
	end

end
