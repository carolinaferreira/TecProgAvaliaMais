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
		logger.info("A new attach object was settted, at line 15");
		assert(@attach.kind_of?(Attach), 'The object @attach it could not be instantiated')

		@company = Company.new
		logger.info("A new company object was setted, at line 19");
		assert(@company.kind_of?(Company), 'The object @company it could not be instantiated')

		@company = Company.find(params[:company_id])
		logger.info("A company is being requested to show at line 23");
		assert(@company == nil, 'The object @company is null')

	end

	# Name: show.
	# Objective: find an Attach object to be present.
	# Parameters: identifier of attach.
	# Return: attach.

	def show

		@attach = Attach.find(params[:id])
		logger.info("A attach is being requested to show at line, 36");
		assert(@attach == nil, 'The object @attach is null')

	end

	# Name: create.
	# Objective: cretate and set a object of type Attach.
	# Parameters: nothing.
	# Return: attach.

	def create

		@attach = Attach.new(attach_params)
		logger.debug('A attach new attach objetc was setted, line 49')
		assert(@attach.kind_of?(Attach), 'The object @attach it could not be instantiated')

		@attach.user = current_user
		logger.info("Status of attach user was setted, at line 53");
		assert(@attach.user == nil, 'The object @attach is null')

		if (@attach.save)
			flash[:notice] = 'Solicitação feita com sucesso!'
			return redirect_to company_path(@attach.company_id)
			logger.info('The application has been redirect to company path, line 59')
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

		ATTACH_ARRAY_SIZE = Attach.all.size
		COMPANY_ARRAY_SIZE =  Company.all.size

		if (attach.size <= ATTACH_ARRAY_SIZE && attach.size => 0)
			if (company.size <=  COMPANY_ARRAY_SIZE && company.size =>0)
				company.update_attributes(:user_id => attach.user_id, :authenticated => true)
				attach.destroy
				flash[:notice] = 'Empresa vinculada com sucesso!'

				return redirect_to management_attach_path
				logger.info("The application has been redirect to management attach path, at line 81");

			else
				# Nothing to do.
			end
		else
			rescue Exception("Error condition, at line 81")
		end

	end

	# Name: reject.
	# Objective: rejects the attempt to add a new company.
	# Parameters: format.
	# Return: nothing.

	def reject

			# find a attach to reject the user request for attach
			attach = Attach.find(params[:format])
			ATTACH_ARRAY_SIZE = Attach.all.size

			if (attach.size <= ATTACH_ARRAY_SIZE && attach.size => 0)
				attach.destroy
				flash[:notice] = 'Vínculo rejeitado com sucesso!'

				return redirect_to management_attach_path
				logger.info("The application has been redirect to management attach path, at line 81");

			else
			rescue Exception("Error condition, at line 110")
			end

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
