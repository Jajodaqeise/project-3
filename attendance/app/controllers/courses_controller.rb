class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  geocode_ip_address

  def index
    @courses = Course.all
    if current_student
      @student_courses = current_student.courses
      @enrolled_courses = []
      @student_courses.each do |course|
        @course = Course.find(course)
        @enrolled_courses << @course
      end
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

    if current_student
      classes = @course.class_dates
      current_class = false
      classes.each do |class_date|
        now = DateTime.now
        byebug
        if class_date.date - (5 * 60) < now && now < class_date.date + (10 * 60)
          current_class = class_date.id
        end
      end
      if current_class
        lat = session[:geo_location].lat
        lng = session[:geo_location].lng
        byebug
        @attender = Attender.new()
        @attender.student_id = current_student.id
        @attender.class_date_id = current_class
      end



    end

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
