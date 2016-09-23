# File: users_controller.rb
# Purpose: Controller of users
# License: AGPL.


class UsersController < ApplicationController

	# Name: new
	# Objective: instantiates an object of type User
	# Parameters: none
	# Return: user object

	def new

		if (logged_in? == false)
	 		@user = User.new
	 		return @user
		else
			return redirect_to home_path
		end

	end

	# Name: show
	# Objective: find an User object to be present
	# Parameters: identifier of an User
	# Return: user object

	def show

		@user = User.find(params[:id])
		if (@user == current_user)
			return @user
		else
			return redirect_to home_path
		end

	end

	# Name: create
	# Objective: create an user and set it as current user
	# Parameters: user parameters
	# Return: redirection to home page

	def create

	 	@user = User.new(set_user_parameters)
		if (@user.save)
			session[:user_id] = @user.id #iniciate a new session
			log_in @user
			flash[:notice] = 'Cadastro efetuado com sucesso!'
			return redirect_to home_path
		else
			return render :new
		end

	end

	# Name: edit
	# Objective: find an User object to be present
	# Parameters: identifier of an User
	# Return: user object

	def edit

		@user = User.find(params[:id])
		if (@user == current_user)
			return @user
		else
			return redirect_to home_path
		end

	end

	# Name: destroy
	# Objective: destroy an user
	# Parameters: user identifier
	# Return: redirection to home page

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
		return redirect_to home_path

	end

	# Name: update
	# Objective: update some user attributes
	# Parameters: new user attributes descriptions
	# Return: user object

	def update

    	@user = User.find(params[:id])
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

  	# Name: update_password
	# Objective: update user password
	# Parameters: current password, new password and passwod confirmation
	# Return: a user object

  	def update_password

  		@user = User.find(params[:id])
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

	# Name: delete_user_company_association
	# Objective: set as false a user's companies authentications
	# Parameters: user companies
	# Return: none

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

		def update_user_attributes

			params[:user].permit(:name, :dateBirthday, :gender)

		end

		def set_new_password

			params[:user].permit(:password, :password_confirmation)

		end

end
