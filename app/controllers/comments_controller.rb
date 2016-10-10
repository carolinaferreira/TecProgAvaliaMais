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
		logger.debug('A new comment has been created')
		assert(@comment.kind_of(Comment), 'The object @comment it could not be instantiated'
    + 'because does not belong to controller')

		return redirect_to(Topic.find(params[:comment][:topic_id]))
		logger.info('The application has been redirected to the topic in which it the comment belongs')

	end

	# Name: edit.
	# Objective: enables comment editing the selected topic.
	# Parameters: comment and comment identifier.
	# Return: nothing.

	def edit

		comment = Comment.find(params[:comment][:comment_id])
		logger.debug('A comment #{comment.comment_id} is being requested to edit')
		assert(comment.user_id != nil, 'The attribute user_id of comment object is null')

		edit_comment_params(comment)
		logger.debug('A comment #{comment.comment_id} has been edited')
		assert(comment != nil, 'The comment object isnt null')

		return redirect_to(Topic.find(comment.topic_id))
		logger.info('The application has been redirected to the topic in which it the comment belongs')

	end

	# Name: destroy.
	# Objective: delete the comment.
	# Parameters: comment format.
	# Return: nothing.

	def destroy

		comment = Comment.find(params[:format])
		logger.debug('A comment #{comment.comment_id} is being requested to destroy')
		assert(comment.kind_of(Comment), 'The object @comment it could not be instantiated'
    + 'because does not belong to controller')

		comment.denunciations.delete_all # It should be deleted the complaints because the attribute is foreign key
		logger.debug('All denunciations of comment #{comment.comment_id} has been deleted')
		assert(comment.denunciations == 0, 'The denunciations of comment was not deleted')

		# This variable saves the topic id because will then be redirected to topic page after the comment has deleted
		topic_id_of_comment_destroyed = comment.topic_id
		logger.info('The id of topic to which belongs the comment was saved')

		comment.destroy
		logger.debug('The comment #{comment.comment_id} has been deleted')
		assert(comment == nil, 'The comment object isnt null')

		return redirect_to Topic.find(topic_id_of_comment_destroyed)
		logger.info('The application has been redirected to the topic in which it the comment belonged')

	end

	# Name: edit_comment_params.
	# Objective: set the parameters of the comments and the parameters that can be edited.
	# Parameters: comment, new description, description, user identifier and topic identifier.
	# Return: nothing.

	private

		def edit_comment_params(comment)

			comment.update_attributes(:description => params[:comment][:new_description])
			logger.debug('The params of edit comment has been set')

		end

	# Name: set_comment_params.
	# Objective: set the parameters of the comments to create.
	# Parameters: comment, new description, description, user identifier and topic identifier.
	# Return: nothing.

	private

		def set_comment_params

			params[:comment].permit(:description, :user_id, :topic_id)
			logger.debug('The params of new comment has been set')

		end

end
