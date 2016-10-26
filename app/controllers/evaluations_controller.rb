# Class: evaluations_controller.rb.
# Purpose: This class aims to manage evaluations of companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class EvaluationsController < ApplicationController

	# Name: rate.
	# Objective: this method update an existing evaluation or creates.
	# Parameters: evaluations, user_id, company_id.
	# Return: nothing.

	def rate

		evaluation = Evaluation.where(	:user_id => params[:evaluations][:user_id],
									 	:company_id => params[:evaluations][:company_id])
		company = Company.find_by(id: params[:evaluations][:company_id])

		if(evaluation.present?)
			evaluation.update_all(:grade => params[:evaluations][:grade])
			size = company.evaluations.where('grade is not null').size
			company.update_attributes(:rate => (company.evaluations.sum(:grade).to_f)/size)
			flash[:notice] = 'Avaliação alterada com sucesso!'
		else
			evaluation = Evaluation.new(rate_params)
			company.update_attributes(:rate => (params[:evaluations][:grade	]))
			if(evaluation.save)
				flash[:notice] = 'Avaliação realizada com sucesso!'
			else
				# nothing to do
			end

		end

		return redirect_to company

	end

	# Name: response_time.
	# Objective: this method allows evaluation of the class for answers time the questions asked.
	# Parameters: response, user_id and company_id.
	# Return: nothing.

	def response_time

		evaluation = Evaluation.where( 	:user_id => params[:response][:user_id],
									 	:company_id => params[:response][:company_id])
		company = Company.find_by(id: params[:response][:company_id])

		if(evaluation.present?)
			evaluation.update_all(:response_time => params[:response][:response_time])
			size = company.evaluations.where('response_time is not null').size
			company.update_attributes(:response_time => (company.evaluations.sum(:response_time).to_f)/size)
			flash[:notice] = 'Avaliação por tempo de resposta alterada com sucesso!'
		else
			evaluation = Evaluation.new(response_params)
			company.update_attributes(:response_time => (params[:response][:response_time]))
			if(evaluation.save)
				flash[:notice] = 'Avaliação por tempo de resposta realizada com sucesso!'
			else
				# nothing to do
			end
		end

		redirect_to company

	end

	# Name: rate_params
	# Objective: this method set parameters of evaluation.
	# Parameters: don't have parameters.
	# Return: nothing.

	def rate_params

		params[:evaluations].permit(:grade, :company_id, :user_id)

	end

	# Name: response_params
	# Objective: this method set parameters of response.
	# Parameters: don't have parameters.
	# Return: redirect to the login page.

	def response_params

		params[:response].permit(:response_time, :company_id, :user_id)

	end

end
