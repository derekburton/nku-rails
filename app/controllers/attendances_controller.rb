class AttendancesController < ApplicationController
  def create
    @attendance = Attendance.new
    
  end
end
