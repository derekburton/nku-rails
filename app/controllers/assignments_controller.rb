class AssignmentsController < ApplicationController
  
  def index 
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    
    @students = Student.all
    if(Student.find(session[:student_id]).admin == true)
      if(params[:student_id])
        @assignments = Assignment.where(student_id: params[:student_id])
      else
        @assignments = Assignment.all
      end
    else
      @assignments = Assignment.where(student_id: session[:student_id]
    end
  end
  
  def new
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    
    if(Student.find(session[:student_id]).admin == false)
      redirect_to students_path
      flash[:error] = "Unauthorized"
    else
      @assignment = Assignment.new
      @students = Student.all
    end
  end
  
  def create
    
  end
    
end
