class CoursesStudentsController < ApplicationController
  before_action :require_user
  before_action :require_student
  def create

  end

  def show
    @student = Student.find(params[:student_id])
    # puts " student #{@student} "
    @course = Course.find(params[:id])
    # puts "course #{@course}"
    # buybug

    @student_courses = @student.courses
    # puts "student courses #{@student.courses}"

    course = []
    @student_courses.each do |course|
      if course == @course
        course = @course
      end
    end

    if course.length > 0
      puts "hey"
      flash[:alert] = "You are already registered in this course"
      redirect_back fallback_location: courses_path
    else
      if @student.courses.include?(@course)
        puts "course exists"
        flash[:alert] = "You have already registered for this course"
        redirect_back fallback_location: courses_path
      else
        @student.courses << @course
        if @student.save
            flash[:notice] = "Student registered successfully!"
            redirect_to course_path @course
        else
            flash[:alert] = "Couldn't registered for this course"
            redirect_back fallback_location: courses_path
        end
      end
    end
  end

  private

  def course_student_params
    params.require(:course_student).permit(:student_id, :course_id)
  end
end
