# Class: uf.rb.
# Purpose: To create the local based on federative unit.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Uf < ActiveRecord::Base
	has_many :evaluations
	has_many :companies
	has_many :users

end
