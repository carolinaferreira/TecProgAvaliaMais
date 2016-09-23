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
		assert(@attach.kind_of?(Attach), 'The object @attach it could not be instantiated')

		@company = Company.new
		assert(@company.kind_of?(Company), 'The object @company it could not be instantiated')

		@company = Company.find(params[:company_id])
		assert(@company == nil, 'The object @company is null')

	end

	# Name: show.
	# Objective: find an Attach object to be present.
	# Parameters: identifier of attach.
	# Return: attach.

	def show

		@attach = Attach.find(params[:id])
		assert(@attach == nil, 'The object @attach is null')

	end

	# Name: create.
	# Objective: cretate and set a object of type Attach.
	# Parameters: nothing.
	# Return: attach.

	def create

		@attach = Attach.new(attach_params)
		assert(@attach.kind_of?(Attach), 'The object @attach it could not be instantiated')

		@attach.user = current_user
		assert(@attach.user == nil, 'The object @attach is null')

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
