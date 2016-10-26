# Class: faq_controller.rb.
# Purpose: This class controls faqs about companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class FaqController < ApplicationController

  # Name: create.
  # Objective: this method create a new faq to companies.
  # Parameters: company_id.
  # Return: redirect_to company.

  def create
    faq = Faq.new(faq_params)

    if(faq.save)
        company = Company.find(params[:faq][:company_id])
        flash[:notice] = 'Cadastrado com sucesso!'
    else
        #nothinh to do
    end

    return redirect_to company

  end

  # Name: faq_params.
  # Objective: this method is used to set the params.
  # Parameters: :question, :answer, :company_id.
  # Return: nothing.
  
  def faq_params
    params[:faq].permit(:question, :answer, :company_id)

  end

end
