class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index

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
    # @course = Course.find(params[:id])
  end

  def edit
    # @course = Course.find(params[:id])
    # render :json => @course
  end

  def update
    # @course = Course.find(params[:id])
    byebug
    if @course.update(course_params)
      redirect_back fallback_location: course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    # @course = Course.find(params[:id])
    if @course.destroy
      redirect_to courses_path
    else
      redirect_to @course
    end
  end

private

  def course_params
    params.require(:course).permit(:name, :school, :description, :teacher_id, :lat, :lng)
  end
  def set_course
    @course = Course.find(params[:id])
  end

end
