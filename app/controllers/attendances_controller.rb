class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def index
    @attendances = Attendance.all
  end
  
  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to attendances_path
      flash[:created] = "You have sucessfully logged your attendance"
    else
      render 'new'
    end
  end
  
  private
  def attendance_params
    params[:attendance][:attended_on] = Date.today
    params[:attendance][:student_identification] = current_student.id
    params.require(:attendance).permit(:attended_on, :seat, :student_identification)
  end
end
