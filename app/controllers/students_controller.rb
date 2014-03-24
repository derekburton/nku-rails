class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def new_upload
  end
  
  def upload
    StudentUploader.new(params[:file]).import
    redirect_to students_path
    flash[:updated] = "New student created"
  end
  
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
  
  def create
    @student = Student.new(params[:student].permit(:name, :nickname, :email, :url, :password, :password_confirmation))        
    
    if @student.save
      redirect_to students_path
      session[:student_id] = @student.id
      flash.now[:saved] = 'Student created'
    else
      render 'new'
    end
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def edit
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    @student = Student.find(params[:id])
  end
  
=begin
When updating, can only update if session's user id is same as the student's id. 
=end
  
  def update
    if(session[:student_id] == nil)
       redirect_to signin_session_path
    end
    
    @student = Student.find(params[:id])
 
    if session[:student_id] == @student.id
      if @student.update(params[:student].permit(:name, :nickname, :email, :url, :password_digest))
        redirect_to students_path
        flash[:update] = 'Student updated'
      else
        render 'edit'
      end
    else
      flash[:error] = 'Not logged in as student'
      redirect_to students_path
    end
  end
  
end