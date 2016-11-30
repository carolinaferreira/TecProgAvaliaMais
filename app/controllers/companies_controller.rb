# Class: companies_controller.rb.
# Purpose: This class is designed to control the actions of companies within the Avalia Mais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class CompaniesController < ApplicationController

	# Name:
	# 	- new
	# Objective:
	# 	- this method create a new instance of company on system.
	# *	*Args* :
	#  	- don't have parameters.
	# * *Returns* :
	# 	- +login_path+ -> redirect to the login page.

	def new

		@company = Company.new(nil)
		logger.debug('A new company has been instantiated')

		if(current_user.nil?) # Checks if the current user is logged to register a company on system.
			return redirect_to(login_path)
			flash[:alert] = 'Para cadastrar uma empresa é preciso estar logado'
		else
			return @company
		end

	end

	# Name:
	# 	- switch_medal_image.
	# Objective:
	# 	-	this method set the name of medal to show on company page.
	# *	*Args* :
	# 	- +company_evaluation+ -> evaluation of companies.
	# * *Returns* :
	# 	- +medal_image_name+ -> the name of medal to switch on company page.

	def switch_medal_image(company_evaluation)

		LIMIT_TO_GOLD = 4.0
		LIMIT_TO_SILVER = 3.99
		LIMIT_TO_BRONZE = 2.49
		medal_image_name = "medal" # Name of the company medal will be displayed on your page.

		# Select the correct name of the medal according to the company's ratings
		if(company_evaluation >= LIMIT_TO_GOLD)
			medal_image_name = 'gold_medal.png'
			logger.debug('The medal of the company was changed to gold')
		elsif(company_evaluation <= LIMIT_TO_SILVER && company_evaluation >= LIMIT_TO_BRONZEc)
			medal_image_name = 'silver_medal.png'
			logger.debug('The medal of the company was changed to silver')
		else
			medal_image_name = 'bronze_medal.png'
			logger.debug('The medal of the company was changed to bronze')
		end

		return medal_image_name
		logger.debug('The method returns the correct name of the companys medal according to their evaluations')

	end

	# Name:
	# 	- show
	# Objective:
	# 	- this method renders the company's page.
	# *	*Args* :
	#  	- +params[:id]+ -> id of used company.
	# * *Returns* :
	#   - +@current_evaluation+ -> total evaluations of actually used company.
	# 	- +@company+ -> object of used company.

	def show

		@company = Company.find(params[:id]) # Find the company by id to later show your page on screen.
		logger.debug('Company is being found through your identifier')

		if(!@company.rate.nil?)
			@company_assessment_average = @company.rate
			@medal_image_name = switch_medal_image(@company_assessment_average)
			logger.debug('Selected the companys medal name')
		else
			#nothing to do
		end

		if(logged_in?)
			@current_evaluation = current_user.evaluations.find_by(company_id: @company.id)
			logger.debug('Checked if the current user has evaluated the company')
		else
			return @company
			logger.info('The application redirect to found company page')
		end

	end

	# Name:
	#  	- create
	# Objective:
	#  	- this method create a new instance of company on system.
	# *	*Args* :
	#  	- +set_company_params_to_create+ -> name, segment id, address, telephone, email, description, logo and UF id of company
	# * *Returns* :
	#  	- +@company+ -> redirect to company page.

	def create

		@company = Company.new(set_company_params_to_create)
		logger.debug('A new company has been created')

		@company.authenticated = false # The false value is the default for company authentication.

		if(@company.save)
			flash[:notice] = 'Cadastro efetuado com sucesso!'
			return redirect_to(@company)
			logger.info('Redirected to the company page created')
		else
			return render(:new)
			logger.debug('redirected to the companys creation page')
		end

	end

	# Name:
	#   - edit
	# Objective:
	#  	- this method checks whether the logged user is the owner of the corresponding company.
	# *	*Args* :
	# 	- +:company+ -> company object.
	#  	- +:id+ -> id of company object.
	# * *Returns* :
	#  	- +@company+ -> redirect to page of company.

	def edit

		@company = Company.find(params[:company][:id])

		if(@company.user_id != current_user.id)
			return redirect_to(home_path)
		else
			return @company
		end

	end

	# Name:
	#  	- update
	# Objective:
	#  	- this class edit an company in the database.
	# *	*Args* :
	#  	- +:company+ -> company object.
	#  	- +:id+ -> id of company object.
	# * *Returns* :
	#  	- +@company+ -> redirect to page of edited company.

	def update

		@company = Company.find(params[:company][:id])

		COMPANIES_ARRAY_SIZE = Company.all.size

		if(@company.size => 0 && @company.size <= 1 )
			if(@company.update_attributes(set_company_params_to_update))
				flash[:notice] = 'Atributo atualizado com sucesso'
			else
				flash[:notice] = 'Erro ao atualizar o atributo!'
			end

			return render(:edit)
		else
			rescue Exception ("Error")
		end

	end

	# Name:
	# 	 - search
	# Objective:
	#  	- this method search companies by name within the system.
	# *	*Args* :
	# 	- +:company+ -> company object.
	#  	- +:id+ -> id of company object.
	# * *Returns* :
	# 	- +@company+ -> redirect to page of finded company.

	def search

		@search_param = params[:current_search][:search]
  		@company = Company.where("name LIKE :search", :search => "%#{params[:current_search][:search]}%")

		COMPANIES_ARRAY_SIZE = Company.all.size

		if(@company.size <= COMPANIES_ARRAY_SIZE && @company.size >= 0 )
			return @company
		else
			rescue Exception ("Error")
		end

  	return @company

	end

	# Name:
	# 		- set_company_params_to_create
	# Objective:
	# 		- this method leads the company's parameters for the method create.
	# *	*Args* :
	# 		- +:company+ -> company object.
	# * *Returns* :
	# 		- don't have return.

	private

		def set_company_params_to_create

			params[:company].permit(:name, :segment_id, :address, :telephone, :email, :description, :logo, :uf_id)

		end

		# Name:
		#  		- set_company_params_to_update
		# Objective:
		# 		- this method leads the company's parameters for the method update.
		# *	*Args* :
		# 		- +:company+ -> company object.
		# * *Returns* :
		# 		- don't have return.

	private

		def set_company_params_to_update

			params[:company].permit(:name, :address, :telephone, :email, :description, :logo, :uf_id)

		end

end
