class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    # @course = Course.all
    # @student = Student.find(current_student)
    # @student_courses = @student.courses
    # @teacher = Teacher.find(current_teacher)
    # @teacher_courses = @teacher.courses
    # byebug
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
        flash[:notice] = "Course created successfully!"
        redirect_to @course
    else
        flash[:alert] = "Make sure you fill in all fields"
        redirect_back fallback_location: new_course_path
    end
  end

  def show
    @students = @course.students
    # byebug
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path
    else
      redirect_to @course
    end
  end

private

  def course_params
    params.require(:course).permit(:name, :school, :description, :teacher_id, :lat, :lng, :start_date, :end_date)
  end
  def set_course
    @course = Course.find(params[:id])
  end

end
