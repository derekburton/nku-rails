class ChangeAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :student_identification, :integer
  end
end
