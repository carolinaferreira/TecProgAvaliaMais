# Class: evaluation.rb.
# Purpose: To create evaluations about any company.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Evaluation < ActiveRecord::Base
    belongs_to :user
    belongs_to :company
    belongs_to :uf

end
