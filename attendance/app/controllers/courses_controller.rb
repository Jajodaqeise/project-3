class CoursesController < ApplicationController

  def index


    response = HTTParty.get(
          "https://maps.googleapis.com/maps/api/place/textsearch/json?query=shillington+school+in+new+york&key=AIzaSyClwYiKGAt5Ia23N0EK8trzEZ_L-8oYAgk").parsed_response
          # :headers => headers
          # ).parsed_response

    results = response["results"]

    results.each do |result|
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

private

  def course_params

    params.require(:course).permit(:name, :school, :description, :teacher_id, :lat, :lng)

      params.require(:course).permit(:name, :school, :description, :teacher_id, :lat, :lng)

  end

end
