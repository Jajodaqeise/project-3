class Api::AttendersController < ApplicationController
  require 'haversine'
  def check
    distance_check = 80
    lat = params[:student_lat].to_f
    lng = params[:student_lng].to_f

    @class_date = ClassDate.find(params[:class_id])
    @course = @class_date.course

    @student = Student.find(params[:student_id])

    distance = Haversine.distance(lat, lng, @course.lat, @course.lng)
    meters = distance.to_meters


  end
end
