# Class: segments_controller.rb.
# Purpose: This class controls the segments of companies.
# Avalia Mais.
# FGA - Universidade de Brasíilia UnB.

class SegmentsController < ApplicationController

    # Name: show_segment.
    # Objective: this method shows segment about any company.
    # Parameters: :name.
    # Return: @company, @segment.

    def show_segment

        @company = Company.all.order(:name)
        @segment = Segment.all

        return @company
        return @segment

    end

end
