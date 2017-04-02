class StudentsController < ApplicationController
  def index

    @course = params[:course_id]
    @students = @course.students
    render layout: "nav"

  end
  def show
    @student = params[:id]
    @courses = @student.courses
    render layout: "nav"
  end

end
