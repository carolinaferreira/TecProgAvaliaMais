# Class: questions_controller.rb.
# Purpose: this class controls all of questions dependences
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class QuestionsController < ApplicationController

    # Name:
	# 	- new
	# Objective:
	# 	- instantiates an object of type questions and associate that on a company.
	# *	*Args* :
	#  	- company identifier.
	# * *Returns* :
	# 	- +@question+ -> question object
	# 	- +@company+ -> company object

    def new

        @question = Question.new
        @company = Company.find(params[:question][:company_id])

        return @question
        return @company

    end

    # Name:
	# 	- create
	# Objective:
	# 	- creating a question
	# *	*Args* :
	#  	- question parameters.
	# * *Returns* :
	# 	- +@question+ -> question object

    def create

        @question = Question.new(question_params)

        if @question.save!
            redirect_to @question
        else
            # nothing to do
        end
    end

    # Name:
	# 	- show
	# Objective:
	# 	- find a question to be presented
	# *	*Args* :
	#  	- question identifier.
	# * *Returns* :
	# 	- +@question+ -> question object

    def show

        @question = Question.find(params[:id])

        return @question

    end

    # Name:
	# 	- results
	# Objective:
	# 	- checking questions votes and options
	# *	*Args* :
	#  	- question identifier.
	# * *Returns* :
	# 	- +@question+ -> question object
	# 	- +@votes+ -> question votes
	# 	- +@options+ -> question options

    def results

        @question = Question.find(params[:id])
        @votes = @question.votes
        @options = @question.option

        return @question
        return @votes
        return @options

    end

    private

        def question_params

            params.require(:question).permit(:title, :company_id, :option_attributes => [:title, :question_id])

        end

end
