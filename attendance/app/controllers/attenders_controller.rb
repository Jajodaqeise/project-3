class AttendersController < ApplicationController

  def create
    # @student = params
    # byebug
    location = IpGeocoder.geocode()
    course = ClassDate.find(params[:attender][:class_date_id]).course
    byebug
    student_location = Geokit::LatLng.new()
    if course.within()
    @attender = Attender.new(attender_params)
    if @attender.save
    #   # byebug
        flash[:notice] = "Checked in successfully!"
        redirect_back fallback_location: course_path
        puts @attender
    else
        flash[:alert] = "Make sure you are in the right location"
        redirect_back fallback_location: course_path
    end
  end

private

  def attender_params
    params.require(:attender).permit(:student_id, :class_date_id)
  end
end
