# Class: faq_controller.rb.
# Purpose: This class controls faqs about companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class FaqController < ApplicationController

  # Name:
  #   - create.
  # Objective:
  #   - this method create a new faq to companies.
  # * *Args* :
  #   - +company_id+ -> id of company.
  # * *Returns* :
  #   - +company+ -> redirect to the login page.

  def create

    faq = Faq.new(faq_params)
    logger.debug('A new faq object has been instantiated')
    assert(faq != nil, 'The faq object is null')

    # save the faq on your company related
    if(faq.save)
      assert(faq.save != false, 'Faq object dont was not saved')
      company = Company.find(params[:faq][:company_id])
      assert(company != nil, 'The company object is null')
      flash[:notice] = 'Cadastrado com sucesso!'
    else
      # nothing to do.
    end

    return redirect_to(company)

  end

  # Name:
  #   - set_faq_parameters.
  # Objective:
  #   - this method is used to set the params.
  # * *Args* :
  #   - +:question+ -> question of param.
  #   - +:answer+ -> answer of param.
  #   - +company_id+ -> id of company to param.
  # * *Returns* :
  #   - dont have returns.

  private

    def set_faq_parameters
        
        params[:faq].permit(:question, :answer, :company_id)

    end

end
