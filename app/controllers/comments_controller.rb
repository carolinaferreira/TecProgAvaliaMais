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

		comment = Comment.create(set_comment_params)
		assert(@comment.kind_of(Comment), 'The object @comment it could not be instantiated'
    + 'because does not belong to controller')

		return redirect_to Topic.find(params[:comment][:topic_id])

	end

	# Name: edit.
	# Objective: enables comment editing the selected topic.
	# Parameters: comment and comment identifier.
	# Return: nothing.

	def edit

		comment = Comment.find(params[:comment][:comment_id])
		assert(comment.user_id != nil, 'The attribute user_id of comment object is null')

		edit_comment_params(comment)
		assert(comment != nil, 'The comment object isnt null')

		return redirect_to(Topic.find(comment.topic_id))

	end

	# Name: destroy.
	# Objective: delete the comment.
	# Parameters: comment format.
	# Return: nothing.

	def destroy

		comment = Comment.find(params[:format])
		assert(comment.kind_of(Comment), 'The object @comment it could not be instantiated'
    + 'because does not belong to controller')

		topic = comment.topic_id
		comment.denunciations.delete_all
		assert(comment.denunciations == 0, 'The attribute denunciations of comment was not deleted')

		comment.destroy
		assert(comment == nil, 'The comment object isnt null')

		return redirect_to Topic.find(topic)

	end

	# Name: set_comment_params.
	# Objective: set the parameters of the comments and the parameters that can be edited.
	# Parameters: comment, new description, description, user identifier and topic identifier.
	# Return: nothing.

	private
		def set_comment_params

			params[:comment].permit(:description, :user_id, :topic_id)

		end

		def edit_comment_params(comment)

			comment.update_attributes(:description => params[:comment][:new_description])

		end

end
