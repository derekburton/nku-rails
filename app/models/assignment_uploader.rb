require 'csv'

class AssignmentUploader
  def initialize(file)
    @file = file
  end
  
  def import  
    CSV.foreach(@file.path, :headers => true) do |row|
      student = Student.find_by(email: row["Email"])
      @count = 0
      if(Assignment.where(student_id: student.id, name: row["Assignment Name"], total: row["Total"]).empty?)
        Assignment.create(student_id: student.id, name: row["Assignment Name"], total: row["Total"], score: row["Score"])
        bool = false
        @count = @count + 1
      end
    end
    
    flash[:created] = "#{@count} assignments were created."
    redirect_to assignments_path
    
  end
end