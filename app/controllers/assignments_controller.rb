class AssignmentsController < ApplicationController
  
  def index 
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    
    @students = Student.where(admin: false)
    
    if(Student.find(session[:student_id]).admin == true)
      if(params[:student_id])
        @assignments = Assignment.where(student_id: params[:student_id])
      else
        @assignments = Assignment.all
      end
    else
      if(params[:student_id])
        redirect_to student_path
        flash[:error] = "Can't access other people's grades"
      end
      @assignments = Assignment.where(student_id: session[:student_id])
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
      @students = Student.where(admin: false)
    end
  end
  
  def create
    @assignment = Assignment.new(params[:assignment].permit(:student_id, :name, :score, :total))
    if @assignment.save
      redirect_to students_path
      flash[:saved] = 'Assignment created'
    else
      render 'new'
    end
  end
    
end
