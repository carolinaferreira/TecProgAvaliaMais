# Class: denunciation.rb.
# Purpose: To create denunciations about any company.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Denunciation < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic
    belongs_to :comment

end
