class CreateCourseStudentTable < ActiveRecord::Migration[5.0]
  def change
    create_table :course_student_tables do |t|
      t.belongs_to :student, index: true
      t.belongs_to :course, index: true
    end
  end
end
