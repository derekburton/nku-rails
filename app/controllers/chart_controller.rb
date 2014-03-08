class ChartController < ApplicationController
  
  def index
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    
    @students = Student.all
    if(params[:selected_date] == nil)
      @attended_on_date = Date.today
    else
      @attended_on_date = params[:selected_date]
    end
  end
  
end
