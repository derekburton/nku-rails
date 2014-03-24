require 'csv'

class StudentUploader
  def initialize(file)
    @file = file
  end
  
  def import  
    CSV.foreach(@file.path, :headers => true) do |row|
      Student.create!(email: row["email"], nickname: row["nickname"], name: row["name"], 
        url: row["image_url"], password: row["password"], password_confirmation: row["password"])
    end
  end
end
