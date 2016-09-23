# Class: comments_controller.rb.
# Purpose: This class controls the comments to be made on the topics.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class CommentsController < ApplicationController

	# Name: create.
	# Objective: creates a comment on the selected topic.
	# Parameters: comment and topic identifier.
	# Return: nothing.

	def create

		comment = Comment.create(comment_params)

		return redirect_to Topic.find(params[:comment][:topic_id])

	end

	# Name: edit.
	# Objective: enables comment editing the selected topic.
	# Parameters: comment and comment identifier.
	# Return: nothing.

	def edit

		comment = Comment.find(params[:comment][:comment_id])
		edit_comment_params(comment)

		return redirect_to Topic.find(comment.topic_id)

	end

	# Name: destroy.
	# Objective: delete the comment.
	# Parameters: comment format.
	# Return: nothing.

	def destroy

		comment = Comment.find(params[:format])
		topic = comment.topic_id
		comment.denunciations.delete_all
		comment.destroy

		return redirect_to Topic.find(topic)

	end

	# Name: comment_params.
	# Objective: set the parameters of the comments and the parameters that can be edited.
	# Parameters: comment, new description, description, user identifier and topic identifier.
	# Return: nothing.

	private
		def comment_params

			params[:comment].permit(:description, :user_id, :topic_id)

		end

		def edit_comment_params(comment)

			comment.update_attributes(:description => params[:comment][:new_description])

		end

end
