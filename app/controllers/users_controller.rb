# File: users_controller.rb
# Purpose: Controller of users
# License: AGPL.


class UsersController < ApplicationController

	# Name:
	# 	- new
	# Objective:
	# 	- instantiates an object of type User.
	# *	*Args* :
	#  	- none.
	# * *Returns* :
	# 	- +user+ -> user object

	def new

		# create a new user instance to be persisted in the database, if it is not logged in and therefore is already created
		if(logged_in? == true)
	 		return redirect_to(home_path)
	 		logger.info('The application has been redirect to home page, line 21')
		else
			@user = User.new(new)
			logger.debug('A user has been instantiated, line 24')
			assert(@comment.kind_of(User), 'The object @user it could not be instantiated'
    		+ 'because does not belong to controller')

	 		return @user
		end

	end

	# Name:
	# 	- show
	# Objective:
	# 	- find an User object to be present.
	# *	*Args* :
	#  	- identifier of an User.
	# * *Returns* :
	# 	- +user+ -> user object

	def show

		@user = User.find(params[:id])
		logger.debug('A user #{@user.user_id} is being requested to show, line 45')
		assert(@user != nil, 'The comment object is null')

		if(@user == current_user)
			logger.debug('A user object has been returned, line 51')
			return @user
		else
			return redirect_to(home_path)
			logger.info('The application has been redirect to home page, line 53')
		end

	end

	# Name:
	# 	- create
	# Objective:
	# 	- create an user and set it as current user.
	# *	*Args* :
	#  	- user parameters
	# * *Returns* :
	# 	- +home_path+ -> redirect to home page.
	#   - +:new+ -> redirect to user page.

	def create

	 	@user = User.new(set_user_parameters)
	 	logger.debug('A new user object has been created, line 71')
	 	assert(@user != nil, 'The comment object is null')

		if(@user.save)
			assert(@user.save != false, 'A new user dont save in database')
			session[:user_id] = @user.id #iniciate a new session
			log_in(@user)
			flash[:notice] = 'Cadastro efetuado com sucesso!'
			return redirect_to(home_path)
			logger.info('The application has been redirect to home page, line 79')
		else
			return render(:new)
			logger.info('The application has been redirect to user page, line 82')
		end

	end

	# Name:
	# 	- edit
	# Objective:
	# 	- find an User object to be present.
	# *	*Args* :
	#  	- identifier of an User
	# * *Returns* :
	# 	- +user+ -> user object

	def edit

		@user = User.find(params[:id])rams[:id])
		logger.debug('A user #{@user.user_id} is being requested to show, line 45')
		assert(@user != nil, 'The comment object is null')

		if (@user == current_user)
			logger.debug('A user object has been returned, line 104')
			return @user
		else
			return redirect_to home_path
			logger.info('The application has been redirect to home page, line 109')
		end

	end

	# Name:
	# 	- destroy
	# Objective:
	# 	- destroy an user.
	# *	*Args* :
	#  	- identifier of an User
	# * *Returns* :
	# 	- nothing

	def destroy

		#destroy all user dependences on database but don't destroy the references objects
		session[:user_id] = nil
 		user = User.find(params[:id])
 		user.attaches.delete_all
 		delete_user_company_association(user.companies)
 		user.companies.delete_all
 		user.topics.delete_all
 		user.comments.delete_all
 		user.attaches.delete_all
 		user.evaluations.delete_all
 		user.denunciations.delete_all
 		user.destroy

		logger.debug('A user #{@user.user_id} is being requested to be deleted, line 127')
		assert(@user == nil, 'The comment object was not destroyed correctly')

		return redirect_to home_path

	end

	# Name:
	# 	- update
	# Objective:
	# 	- update some user attributes.
	# *	*Args* :
	#  	- new user attributes
	# * *Returns* :
	# 	- +user+ -> user object

	def update

    	@user = User.find(params[:id])
		logger.debug('A user #{@user.user_id} is being requested to be updated, line 157')
		assert(@user != nil, 'The user object can not be null')

    	if (@user.update_attributes(update_user_attributes))
			#Formating user update form with JavaScript, letting this to update without
			#refresh the page
			respond_to do |format|
    			format.html{
    				redirect_to :action => "show",:id => @user.id
    			}
	    		flash[:notice] = "Perfil atualizado"
	    		format.js
	    	end
	    	return @user
    	else
      		flash[:notice] = 'Erro ao atualizar o dado!'
    	end

  	end

	# Name:
	# 	- update_password
	# Objective:
	# 	- update user password.
	# *	*Args* :
	#  	- current password, new password and passwod confirmation
	# * *Returns* :
	# 	- +user+ -> user object

  	def update_password

  		@user = User.find(params[:id])
		logger.debug('A user #{@user.user_id} is being requested to update it password, line 188')
		assert(@user != nil, 'The user object can not be null')

  		if  (@user.authenticate(params[:user][:password_older]))
  			if (@user.update_attributes(set_new_password))
  				flash[:notice] = 'Senha atualizada com sucesso!'
  			else
  				flash[:notice] = 'Senha de confirmação invalida!'
  			end
  		else
  			flash[:notice] = 'Senha invalida!'
  		end

  		return redirect_to :action => "show", :id => @user.id

  	end

	# Name:
	# 	- delete_user_company_association
	# Objective:
	# 	- set as false a user's companies authentications
	# *	*Args* :
	#  	- user companies
	# * *Returns* :
	# 	- nothing

  	def delete_user_company_association(companies)

  		companies.each do |company|
  			company.update_attributes(:authenticated => false)
  		end

  	end

	private

		def set_user_parameters

			params[:user].permit(:name, :email, :password, :password_confirmation,:login,
								 :dateBirthday, :gender, :uf_id, :company_id)

		end

	private

		def update_user_attributes

			params[:user].permit(:name, :dateBirthday, :gender)

		end

	private

		def set_new_password

			params[:user].permit(:password, :password_confirmation)

		end

end
