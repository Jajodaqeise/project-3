class Api::AttendersController < ApplicationController
  require 'haversine'
  def check
    lat = params[:student_lat]
    lng = params[:student_lng]
    @class_date = ClassDate.find(params[:class_id])
    @course = @class_date.course
    @student = Student.find(params[:student_id])
    distance = Haversine.distance(lat, lng, @course.lat, @course.lng)
    meters = distance.to_meters
    byebug
  end
end
