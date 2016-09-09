# File: companies_helper.rb
# Purpose: Method to help the company class.
# License: AGPL.

module CompaniesHelper

            # Name: current_user_company_denunciation
            # Objective:
            # Parameters: company
            # Return:

	def current_user_company_denunciation(company)
	   CompanyDenunciation.find_by(user_id: current_user.id, company_id: company.id)

            end

end