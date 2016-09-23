# File: sessions_helper.rb
# Purpose: Method to help the session class.
# License: AGPL.

module SessionsHelper

	# Name: log_in
           # Objective: Log in the given user
           # Parameters: user, user_id
           # Return:

	def log_in(user)
	   session[:user_id] = user.id

	end

	# Name: current_user
           # Objective: Return the current logged-in user
           # Parameters:
           # Return: @current_user

	def current_user
        	   @current_user ||= User.find(session[:user_id]) if session[:user_id]
                return @current_user

	end

	# Name: authorize
           # Objective:
           # Parameters:
           # Return: redirect_to login_path

	def authorize
	   return redirect_to login_path, alert: "Para cadastrar uma empresa é preciso estar logado" if current_user.nil?

	end

	# Name: logged_in
           # Objective: Returns true if user is logged in, otherwise return false
           # Parameters:
           # Return:

	def logged_in?
	   !current_user.nil?

	end

end