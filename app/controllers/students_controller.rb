class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def index
    @students = Student.all
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
    @student = Student.find(params[:id])
  end
  
=begin
When updating, can only update if session's user id is same as the student's id. 
=end
  
  def update
    @student = Student.find(params[:id])
 
    if session[:user_id] == @student.id
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