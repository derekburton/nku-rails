class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def get_current_student
    if( session[:student_id])
      return Student.find(session[:student_id])
    else
      return nil
    end
  end
  helper_method :get_current_student
  
end
