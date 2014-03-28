require 'csv'

class AssignmentUploader
  def initialize(file)
    @file = file
  end
  
  def import 
    @count = 0
    CSV.foreach(@file.path, :headers => true) do |row|
      student = Student.find_by(email: row["Email"])
      if(Assignment.where(student_id: student.id, name: row["Assignment Name"], total: row["Total"]).empty?)
        Assignment.create(student_id: student.id, name: row["Assignment Name"], total: row["Total"], score: row["Score"])
        bool = false
        @count = @count + 1
      end
    end
    @count
  end
end