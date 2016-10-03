# Class: companies_controller.rb.
# Purpose: This class is designed to control the actions of companies within the Avalia Mais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class CompaniesController < ApplicationController

	# Name: new
	# Objective: this method create a new instance of company on system.
	# Parameters: don't have parameters.
	# Return: redirect to the login page.

	def new

		@company = Company.new(nil)

		if(current_user.nil?)
			return redirect_to(login_path), #alert: "Para cadastrar uma empresa é preciso estar logado"
			flash[:alert] = 'Para cadastrar uma empresa é preciso estar logado'
		else
			return @company
		end

	end

	# Name: switch_medal_image.
	# Objective: this method set the name of medal to show on company page.
	# Parameters: evaluation of companies.
	# Return: the name of medal to switch on company page.

	def switch_medal_image(company_evaluation)

		LIMIT_TO_GOLD = 4.0
		LIMIT_TO_SILVER = 3.99
		LIMIT_TO_BRONZE = 2.49
		medal_image_name = "medal"

		if(company_evaluation >= LIMIT_TO_GOLD)
			medal_image_name = 'gold_medal.png'
		elsif(company_evaluation <= LIMIT_TO_SILVER && company_evaluation >= LIMIT_TO_BRONZE)
			medal_image_name = 'silver_medal.png'
		else
			medal_image_name = 'bronze_medal.png'
		end

		return medal_image_name

	end

	# Name: show
	# Objective: this method renders the company's page.
	# Parameters: company id
	# Return: total evaluations, medal type name and evaluations of company.

	def show

		@company = Company.find(params[:id])

		if(!@company.rate.nil?)
			@total_evaluations = @company.rate
			@image_name = switch_medal_image(@total_evaluations)
		else
			#nothing to do
		end

		if(logged_in?)
			@current_evaluation = current_user.evaluations.find_by(company_id: @company.id)
		else
			return @company
		end

	end

	# Name: create
	# Objective: this method create a new instance of company on system.
	# Parameters: name, segment id, address, telephone, email, description, logo and UF id of company
	# Return: redirect to company page or create company page.

	def create

		@company = Company.new(set_company_params_to_create)
		@company.authenticated = false

		if(@company.save)
			flash[:notice] = 'Cadastro efetuado com sucesso!'
			return redirect_to(@company)
		else
			return render(:new)
		end

	end

	# Name: edit
	# Objective: this method checks whether the logged user is the owner of the corresponding company.
	# Parameters: company object and your id.
	# Return: redirect to intial page or company object.

	def edit

		@company = Company.find(params[:company][:id])

		if(@company.user_id != current_user.id)
			return redirect_to(home_path)
		else
			return @company
		end

	end

	# Name: update
	# Objective: this class edit an company in the database.
	# Parameters: object of company id and your id
	# Return: redirect to company edit page.

	def update

		@company = Company.find(params[:company][:id])

		if(@company.update_attributes(set_company_params_to_update))
			flash[:notice] = 'Atributo atualizado com sucesso'
		else
			flash[:notice] = 'Erro ao atualizar o atributo!'
		end

		return render(:edit)

	end

	# Name: search
	# Objective: this method search companies by name within the system.
	# Parameters: search by name entered by the User
	# Return: object of company.

	def search

		@search_param = params[:current_search][:search]
  	@company = Company.where("name LIKE :search", :search => "%#{params[:current_search][:search]}%")

  	return @company

	end

	# Name: set_company_params_to_create
	# Objective: this method leads the company's parameters for the method create.
	# Parameters: company object.
	# Return: don't have return.

	private

		def set_company_params_to_create

			params[:company].permit(:name, :segment_id, :address, :telephone, :email, :description, :logo, :uf_id)

		end

		# Name: set_company_params_to_update
		# Objective: this method leads the company's parameters for the method update.
		# Parameters: company object
		# Return: don't have return.

	private

		def set_company_params_to_update

			params[:company].permit(:name, :address, :telephone, :email, :description, :logo, :uf_id)

		end

end
