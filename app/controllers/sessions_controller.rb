class SessionsController < ApplicationController
      
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.find_by(email: session_params[:email])
    if @student && @student.authenticate(session_params[:password])
      session[:student_id] = @student.id
      redirect_to chart_path
      flash[:signedup] = 'Welcome'
    else
      flash[:error] = 'Email/password incorrect'
      render 'new'
    end
  end
  
  def destroy
    if session[:student_id]
      session[:student_id] = nil
      flash[:loggedout] = 'Logged out'
      redirect_to students_path
    end    
  end
  
  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
  
end
