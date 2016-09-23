# Class: faq.rb.
# Purpose: To create questions and answers about any company.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Faq < ActiveRecord::Base
    belongs_to :company
    validates :question, presence: true
    validates :answer, presence: true

end
