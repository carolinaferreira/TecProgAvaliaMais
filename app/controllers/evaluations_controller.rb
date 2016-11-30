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
		logger.debug('A new evaluation object has been find, using existing parameters')
	    assert(evaluation.kind_of?(Evaluation), 'The object evaluation it could not be instantiated')

		company = Company.find_by(id: params[:evaluations][:company_id])
		logger.debug('A new company pbject has been created, using existing parameters')
		assert(company.kind_of?(Company), 'The object company it could not be instantiated')

		checking_numeric_values(evaluation.size)

	    # This structure is used to check the existence of an evaluation.
		if(evaluation.present?)
			evaluation.update_all(:grade => params[:evaluations][:grade])
			size = company.evaluations.where('grade is not null').size
			company.update_attributes(:rate => (company.evaluations.sum(:grade).to_f)/size)
			flash[:notice] = 'Avaliação alterada com sucesso!'
		else
			evaluation = Evaluation.new(set_rate_parameters)
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
		assert(evaluation.kind_of?(Evaluation), 'Evaluation object can not be empty')

		company = Company.find_by(id: params[:response][:company_id])
		assert(company.kind_of?(Company), 'Company object can not be empty')

		checking_numeric_values(evaluation.size)

		# This structure is used to check the existence of an evaluation.
		if(evaluation.present?)
			evaluation.update_all(:response_time => params[:response][:response_time])
			size = company.evaluations.where('response_time is not null').size
			company.update_attributes(:response_time => (company.evaluations.sum(:response_time).to_f)/size)
			flash[:notice] = 'Avaliação por tempo de resposta alterada com sucesso!'
		else
			evaluation = Evaluation.new(set_response_parameters)
			company.update_attributes(:response_time => (params[:response][:response_time]))

			if(evaluation.save)
				flash[:notice] = 'Avaliação por tempo de resposta realizada com sucesso!'
			else
				# nothing to do
			end
		end

		return redirect_to company

	end

	private

		def set_rate_parameters

			params[:evaluations].permit(:grade, :company_id, :user_id)

		end

		def set_response_parameters

			params[:response].permit(:response_time, :company_id, :user_id)

		end

		def checking_numeric_values(ARRAY_SIZE, DOWN_LIMIT, HIGHT_LIMIT)

			if(ARRAY_SIZE < DOWN_LIMIT || ARRAY_SIZE > HIGHT_LIMIT)
				return rescue Exception("Invalid values to evalation array.")
			else
				# nothing to do
			end

		end

end
