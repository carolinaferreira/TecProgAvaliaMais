# Class: vote.rb.
# Purpose: To answer questions based on votes.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Vote < ActiveRecord::Base
    belongs_to :question
    belongs_to :option

end
