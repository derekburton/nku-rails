class Student < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 1 }, allow_nil: true
  
  has_many :attendances, dependent: :destroy
  
  def self.in_seat(seat, date=Date.today)
    attendances = Attendance.where("attended_on = ? AND seat = ?", date, seat)
    student_ids = attendances.collect{ |a| a.student_identification }
    return Student.find(student_ids)
  end

  def self.absent(date=Date.today)
    attendances = Attendance.where("attended_on = ?", date)
    present_students = attendances.collect{ |a| a.student_identification }
    return Student.where.not(id: present_students)
  end
  
end
