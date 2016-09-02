# Class: companies_controller.rb.
# Purpose: This class is designed to control the actions of companies within the Avalia Mais.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class CompaniesController < ApplicationController

	# Name: new
	# Objective: This method create a new instance of company on system.
	# Parameters: Don't have parameters.
	# Return: Redirect to the login page.

	def new

		@company = Company.new(nil)

		if(current_user.nil?)
			return redirect_to login_path, alert: "Para cadastrar uma empresa é preciso estar logado"
		else
			return @company
		end

	end

	# Name: switch_medal_image.
	# Objective: This method set the name of medal to show on company page.
	# Parameters: Evaluation of companies.
	# Return: The name of medal to switch on company page.

	def switch_medal_image(company_evaluation)

		medal_image_name = ""

		if(company_evaluation >= 4)
			medal_image_name = "gold_medal.png"
		elsif(company_evaluation <= 3.99 && company_evaluation >= 2.49)
			medal_image_name = "silver_medal.png"
		else
			medal_image_name = "bronze_medal.png"
		end

		return medal_image_name

	end

	# Name: show
	# Objective: This method renders the company's page.
	# Parameters: Company id
	# Return: Total evaluations, medal type name and evaluations of company.

	def show

		@company = Company.find(params[:id])

		if(!@company.rate.nil?)
			@total_evaluations = @company.rate
			@image_name = switch_medal_image(@total_evaluations)
		else
			#default
		end

		if(logged_in?)
			@current_evaluation = current_user.evaluations.find_by(company_id: @company.id)
		else
			return @company
		end

	end

	# Name: create
	# Objective: This method create a new instance of company on system.
	# Parameters: Name, Segment id, Address, Telephone, Email, Description, Logo and UF id of Company
	# Return: Redirect to company page or create company page.

	def create

		@company = Company.new(set_company_params_to_create)
		@company.authenticated = false

		if(@company.save)
			flash[:notice] = 'Cadastro efetuado com sucesso!'
			redirect_to @company
		else
			render :new
		end

	end

	# Name: edit
	# Objective: This method checks whether the logged user is the owner of the corresponding company.
	# Parameters: Company object and your id.
	# Return: Redirect to intial page or company object.

	def edit

		@company = Company.find(params[:company][:id])

		if(@company.user_id != current_user.id)
			redirect_to home_path
		else
			return @company
		end

	end

	# Name: update
	# Objective: This class edit an company in the database.
	# Parameters: Object of company id and your id
	# Return: Redirect to company edit page.

	def update

		@company = Company.find(params[:company][:id])

		if(@company.update_attributes(set_company_params_to_update))
			flash[:notice] = 'Atributo atualizado com sucesso'
		else
			flash[:notice] = 'Erro ao atualizar o atributo!'
		end

		render :edit

	end

	# Name: search
	# Objective: This method search companies by name within the system.
	# Parameters: Search by name entered by the User
	# Return: Object of company.

	def search

		@search_param = params[:current_search][:search]
  	@company = Company.where("name LIKE :search", :search => "%#{params[:current_search][:search]}%")

  	return @company

	end

	# Name: set_company_params_to_create
	# Objective: This method leads the company's parameters for the method create.
	# Parameters: Company object.
	# Return: Don't have return.

	private

		def set_company_params_to_create

			params[:company].permit(:name, :segment_id, :address, :telephone, :email, :description, :logo, :uf_id)

		end

		# Name: set_company_params_to_update
		# Objective: This method leads the company's parameters for the method update.
		# Parameters: Company object
		# Return: Don't have return.

	private

		def set_company_params_to_update

			params[:company].permit(:name, :address, :telephone, :email, :description, :logo, :uf_id)

		end
end
