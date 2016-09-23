# Class: segment.rb.
# Purpose: To create the segment of the company.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Segment < ActiveRecord::Base
    has_many :companies

end
