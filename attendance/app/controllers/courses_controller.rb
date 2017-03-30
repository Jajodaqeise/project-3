class CoursesController < ApplicationController

  def index

  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
        flash[:notice] = "Course created successfully!"
        redirect_back fallback_location: course_path
    else
        flash[:alert] = "Make sure you fill in all fields"
        redirect_back fallback_location: new_course_path
    end
  end

private

  def course_params
    params.require(:course).permit(:name, :school, :description, :teacher_id, :lat, :lng)
  end

end
