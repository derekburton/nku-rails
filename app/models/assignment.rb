class Assignment < ActiveRecord::Base
  
  def self.average_percentage
    assignments = Assignment.all
    amt = 0
    count = 0
    assignments.each do |assign|
      count = count + assign.total
      amt = amt + assign.score
    end
    (amt.to_f / count.to_f) * 100
  end
  
  def percentage
    (score.to_f / total) * 100    
  end
  
end