class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def index
    if(session[:student_id])
      @attendances = Attendance.find_by(student_identification: session[:student_id]
    else
      @attendances = Attendance.all
  end
  
  def create
    @attendance = Attendance.new(attendance_params)
    attendances = Attendance.where("attended_on = ?", Date.today)
    bool = true
    attendances.each do |student|
      if student.student_identification == @attendance.student_identification
        bool = false
      end
    end
    if bool == true
      if @attendance.save
        redirect_to attendances_path
        flash[:created] = "You have sucessfully logged your attendance"
      else
        render 'new'
      end
    else
      flash[:done] = "Already have logged attendance for today"
      redirect_to attendances_path
    end  
  end
  
  private
  def attendance_params
    params[:attendance][:attended_on] = Date.today
    params[:attendance][:student_identification] = current_student.id
    params.require(:attendance).permit(:attended_on, :seat, :student_identification)
  end
end
