# Class: managements_controller.rb.
# Purpose: This class controls the management of companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class ManagementsController < ApplicationController

	# Name: index.
  	# Objective: this method appends the complaints in order on view.
  	# Parameters: .
  	# Return: @attaches, @topic_ordered, @denunciations.

	def index
		@attaches = Attach.all.order(:cnpj)
		@topic_ordered = Topic.joins(:denunciations).select('topics.*,
						count(*) as denunciations_count').group('topics.id').order('denunciations_count DESC')
		comment_ordered
		@denunciations = CompanyDenunciation.all.order(:id)

	end

	# Name: comment_ordered.
  	# Objective: this method order the comments.
  	# Parameters: .
  	# Return: @comment_ordered.

	def comment_ordered
		@comment_ordered = Comment.joins(:denunciations).select('comments.*, count(*) as denunciations_count').group('comments.id').order('denunciations_count DESC')

	end

end