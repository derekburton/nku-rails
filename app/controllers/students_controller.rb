class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def index
    @students = Student.all
  end
  
  def create
    @student = Student.new(params[:student].permit(:name, :nickname, :email, :url))
 
    if @student.save
      redirect_to students_path
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
 
    if @student.update(params[:student].permit(:name, :nickname, :email, :url))
      redirect_to students_path
    else
      render 'edit'
    end
  end
  
end