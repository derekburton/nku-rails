class AttendancesController < ApplicationController
  
  def new
    @attendance = Attendance.new
  end
  
  def index
    if(session[:student_id] == nil)
      redirect_to signin_session_path
    end

    if(params[:student_id].present?)
      @attendances = Attendance.where(student_identification: params[:student_id])
    else
      @attendances = Attendance.all
    end
  end
  
  def create   
    if(session[:student_id] == nil)
      redirect_to signin_session_path    
    else
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
  end
  
  private
  def attendance_params
    params[:attendance][:attended_on] = Date.today
    params[:attendance][:student_identification] = get_current_student().id
    params.require(:attendance).permit(:attended_on, :seat, :student_identification)
  end
end
