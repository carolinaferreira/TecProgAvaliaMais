class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include CompaniesHelper
  include UsersHelper
  include TopicsHelper

  def assert(condition, message)

    if(!condition)
        server_exception(message)
    else
        # nothing to do
    end

  end

end
