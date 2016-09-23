# Class: managements_controller.rb.
# Purpose: This class controls the management of companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class ParsersController < ApplicationController

	# Name: upload.
  	# Objective: this method sends the information to the parser.
  	# Parameters: :document.
  	# Return: redirect_to 'http://0.0.0.0:3000/' or redirect_to 'http://0.0.0.0:3000/parsers' .

	def upload
		document = params[:document]
		if document
			File.open(Rails.root.join('public', 'csv', 'file.csv'), 'wb') do |file|
				file.write(document.read)
			end
			Parser.save_data('public/csv/file.csv')
			return redirect_to 'http://0.0.0.0:3000/'
		else
			return redirect_to 'http://0.0.0.0:3000/parsers'
		end

	end

end
