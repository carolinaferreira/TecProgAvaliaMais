# File: users_helper.rb
# Purpose: Method to help the user class.
# License: AGPL.

module UsersHelper

           # Name: post_date
           # Objective: Formatting date: day/month/year - 9:55PM
           # Parameters: date
           # Return:

	def post_date(date)
    	   date.strftime("%d/%m/%Y ")

            end

end
