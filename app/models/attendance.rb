class Attendance < ActiveRecord::Base
  belongs_to :student
  validates :seat, numericality: { only_integer: true, message: "Must be an integer" }, 
    format: { with: /[1-4]/, message: "Place a valid number for seat (1-4)" }
end
