# Class: company_denunciation_controller.rb.
# Purpose: This class aims to control company denunciations to the system AvaliaMais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class CompanyDenunciationsController < ApplicationController

	# Name: create.
	# Objective: create a denunciation to a specific company.
	# Parameters: company identifier, user identifier and denunciation description.
	# Return: redirection to company page.

	def create

		@company_denunciation = CompanyDenunciation.create( company_id: params[:session][:company_id],
															user_id: params[:session][:user_id],
															description: params[:session][:description])

		if(@company_denunciation)
			flash[:notice] = 'Sua denúncia foi efetuada com sucesso!'
			return redirect_to Company.find(params[:session][:company_id])
		else
			# nothing to do
		end

	end

	# Name: show.
	# Objective: find a company denunciation to be show off.
	# Parameters: company denunciation identifier.
	# Return: company denunciation object.

	def show

		@company_denunciation = CompanyDenunciation.find(params[:format])

		return @company_denunciation

	end

	# Name: destroy.
	# Objective: destroy a specific company denunciation.
	# Parameters: denunciation identifier.
	# Return: attach and company.

	def destroy

		company_denunciation = CompanyDenunciation.find(params[:session][:company_denunciation_id])

		if(company_denunciation.destroy)
	 		flash[:notice] = 'Sua denúncia foi retirada com sucesso!'
			return redirect_to Company.find(params[:session][:company_id])
	 	else
	 		# nothing to do
	 	end

	end
	
end
