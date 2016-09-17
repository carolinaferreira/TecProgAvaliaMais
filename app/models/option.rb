# Class: option.rb.
# Purpose: Options evaluation based on votes.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Option < ActiveRecord::Base
    has_many :vote
    belongs_to :question
    validates :title, :presence => { :message => 'Opção não pode ser vazia!' }

end
