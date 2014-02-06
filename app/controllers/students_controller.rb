class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def index
    @students = Student.all
  end
  
  def create
    @student = Student.new(params[:student].permit(:name, :nickname, :email, :url, :password_digest))
        
    if @student.save
      redirect_to students_path
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
  
  def update
    @student = Student.find(params[:id])
 
    if @student.update(params[:student].permit(:name, :nickname, :email, :url, :password_digest))
      redirect_to students_path
      flash[:update] = 'Student updated'
    else
      render 'edit'
    end
  end
  
end