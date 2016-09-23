# Class: denunciations_controller.rb.
# Purpose: This class handles the complaints made ​​to companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class DenunciationsController < ApplicationController

	# Name: create.
	# Objective: create a topic with the complaint.
	# Parameters: denunciation.
	# Return: nothing.

	def create

		@denunciation = Denunciation.create(topic_id: params[:session][:topic_id], user_id: params[:session][:user_id])
		assert(@denunciation.kind_of?(Denunciation), 'The object @denunciation it could not be instantiated')

		if (@denunciation)

			return redirect_to Topic.find(params[:session][:topic_id])

		else
			# Nothing to do.
		end

	end

	# Name: destroy.
	# Objective: delete the topic with the complaint.
	# Parameters: nothing.
	# Return: nothing.

	def destroy

		denunciation = Denunciation.find(params[:session][:denunciation_id])
		assert(denunciation == nil, 'The object denunciation is null')

		if (denunciation.destroy)

			return redirect_to Topic.find(params[:session][:topic_id])

		else
			# Nothing to do.
		end

	end

	# Name: create_for_comment.
	# Objective: set the parameters of the complaint.
	# Parameters: comment identifier, session, user identifier and topic identifier.
	# Return: denunciation.

	def create_for_comment

		@denunciation = Denunciation.create(comment_id: params[:session][:comment_id], user_id: params[:session][:user_id])
		assert(@denunciation.kind_of?(Denunciation), 'The object @denunciation it could not be instantiated')

		if (@denunciation)

			return redirect_to Topic.find(params[:session][:topic_id])

		else
			# Nothing to do.
		end

	end

end
