# Class: attaches_controller.rb.
# Purpose: This class aims to control companies to be attached to the system AvaliaMais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class AttachesController < ApplicationController

	# Name: new.
	# Objective: instantiate an object of type Attach.
	# Parameters: company_id.
	# Return: attach and company.

	def new

		@attach = Attach.new
		@company = Company.new
		@company = Company.find(params[:company_id])

	end

	# Name: show.
	# Objective: find an Attach object to be present.
	# Parameters: identifier of attach.
	# Return: attach.

	def show

		@attach = Attach.find(params[:id])

	end

	# Name: create.
	# Objective: cretate and set a object of type Attach.
	# Parameters: nothing.
	# Return: attach.

	def create

		@attach = Attach.new(attach_params)
		@attach.user = current_user

		if (@attach.save)
			flash[:notice] = 'Solicitação feita com sucesso!'
			return redirect_to company_path(@attach.company_id)
		else
			return render :new
		end

	end

	# Name: approve.
	# Objective: approves and adds a new company.
	# Parameters: format .
	# Return: nothing.

	def approve

		# search a attach and respective company to approve the user request
		attach = Attach.find(params[:format])
		company = Company.find(attach.company_id)
 		company.update_attributes(:user_id => attach.user_id, :authenticated => true)
		attach.destroy
		flash[:notice] = 'Empresa vinculada com sucesso!'

		return redirect_to management_attach_path

	end

	# Name: reject.
	# Objective: rejects the attempt to add a new company.
	# Parameters: format.
	# Return: nothing.

	def reject

			# find a attach to reject the user request for attach
			attach = Attach.find(params[:format])
			attach.destroy
			flash[:notice] = 'Vínculo rejeitado com sucesso!'

			return redirect_to management_attach_path

	end

	# Name: attach_params.
	# Objective: set the parameters of a company.
	# Parameters: attach.
	# Return: nothing.

	private
		def attach_params

			params[:attach].permit(:cnpj, :address, :photo, :user_id, :company_id)

		end

end
