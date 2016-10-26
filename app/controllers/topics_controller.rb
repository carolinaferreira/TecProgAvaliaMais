# Class: topics_controller.rb.
# Purpose:
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class TopicsController < ApplicationController

	# Name: new.
	# Objective:
	# Parameters: identification of company.
	# Return: topic and company.

	def new

		@topic = Topic.new
		@company = Company.new
		@company = Company.find(params[:company_id])

	end

	# Name: create.
	# Objective:
	# Parameters:
	# Return: topic.

	def create

		@topic = Topic.new(topic_params)
		@topic.user = current_user
		if(@topic.save)

			return redirect_to @topic

		else

			return render(:new)

		end

	end

	# Name: show.
	# Objective:
	# Parameters:
	# Return:

	def show

		@topic = Topic.find(params[:id])
		@comments = @topic.comments.order('id DESC')

	end

	# Name: edit.
	# Objective:
	# Parameters:
	# Return:

	def edit

		@topic = Topic.find(params[:id])
		if(current_user != @topic.user)

			return redirect_to @topic

		else
			#do nothing
		end

	end

	# Name: update.
	# Objective:
	# Parameters:
	# Return:

	def update

		@topic = Topic.find(params[:id])

		if(@topic.update_attributes(topic_params))
    		respond_to do |format| format.html {redirect_to :action => "show",:id => @topic.id}
	    		flash[:notice] = "Tópico atualizado"
	    	end
		else
			# nothing to do
    	end

	end

	# Name: destroy.
	# Objective:
	# Parameters:
	# Return:

	def destroy
		topic = Topic.find(params[:id])
		company = topic.company

		if(topic.destroy)
	    	flash[:notice] = "Tópico excluído!"

				return redirect_to company
		else
			# nothing to do
		end

	end

	# Name: current_user_topic_denunciation.
	# Objective:
	# Parameters:
	# Return:

	def current_user_topic_denunciation

		Denunciation.find_by(topic_id: params[:id], user: current_user)

	end

	helper_method :current_user_topic_denunciation

	# Name: current_user_comment_denunciation(comment_id).
	# Objective:
	# Parameters:
	# Return:

	def current_user_comment_denunciation(comment_id)

		Denunciation.find_by(comment_id: comment_id, user: current_user)

	end

	helper_method :current_user_comment_denunciation

	private

		# Name: topic_params.
		# Objective:
		# Parameters:
		# Return:

		def topic_params

			params[:topic].permit(:title, :body, :company_id, :user_id)

		end

end
