# Class: sessions_controller.rb.
# Purpose: This class is designed to control the actions of session within the Avalia Mais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class SessionsController < ApplicationController

	# Name: new
  # Objective: this method create a new instance of session on system.
  # Parameters: don't have parameters.
  # Return: redirect to home page.

	def new

		if(logged_in?)
			return redirect_to(home_path)
		else
			#nothing to do
		end

	end

	# Name: create
	# Objective: this method create a new session on system.
	# Parameters: user params.
	# Return: render a new page of logged user.

	def create

		user = find_user_record

		if(user && user.authenticate(params[:session][:password]))
			log_in(user)
			flash.now[:notice] = 'Login realizado com sucesso'
			return redirect_to(home_path)
		else
			flash.now[:notice] = 'Login ou senha inválidos'
			return render('new')
		end

	end

	# Name: destroy
	# Objective: this method destroy a session instance.
	# Parameters: user identifier.
	# Return: redirect to login page.

	def destroy

		session[:user_id] = nil
		flash.now[:notice] = 'Logout efetuado com sucesso'

		return redirect_to(home_path)

	end

	# Name: find_user_to_log
	# Objective: find user to log in system with your nickname or email.
	# Parameters: user identifier.
	# Return: redirect to login page.

	private

	def find_user_to_log

		User.find_by(login: params[:session][:login]) || User.find_by(email: params[:session][:login])

	end

end
