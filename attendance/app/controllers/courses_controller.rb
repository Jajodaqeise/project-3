class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    # @course = Course.new

    @student_courses = current_student.courses
    @enrolled_courses = []
    @student_courses.each do |course|
      @course = Course.find(course)
      @enrolled_courses << @course
    end
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
    # @current_student = current_student.courses
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
