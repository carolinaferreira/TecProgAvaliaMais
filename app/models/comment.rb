# Class: comment.rb.
# Purpose: To create comments.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic
    has_many :denunciations
    validates :description, :presence => { :message => 'Não é possível realizar um comentário vazio!' },
                    length: { maximum: 150}

end
