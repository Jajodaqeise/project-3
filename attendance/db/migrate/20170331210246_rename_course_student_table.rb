class RenameCourseStudentTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :course_student_tables, :courses_students
  end
end
