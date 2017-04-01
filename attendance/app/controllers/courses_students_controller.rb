class CoursesStudentsController < ApplicationController

  def create

  end

  def show
    @student = Student.find(params[:student_id])
    # byebug
    @course = Course.find(params[:id])
    @student.courses << @course
    if @student.save
        flash[:notice] = "Student registered successfully!"
        redirect_to course_path @course
    else
        flash[:alert] = "Couldn't registered for this course"
        redirect_back fallback_location: courses_path
    end
  end

  private

  def course_student_params
    params.require(:course_student).permit(:student_id, :course_id)
  end
end
