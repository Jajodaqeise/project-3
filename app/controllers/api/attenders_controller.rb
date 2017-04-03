class Api::AttendersController < ApplicationController
  require 'haversine'
  def check
    distance_check = 80

    lat = session[:geo_location][:lat]
    lng = session[:geo_location][:lng]

    front_end_lat = params[:student_lat].to_f
    front_end_lng = params[:student_lng].to_f

    @class_date = ClassDate.find(params[:class_id])
    @course = @class_date.course

    @student = Student.find(params[:student_id])

    front_end_distance = Haversine.distance(front_end_lat, front_end_lng, @course.lat, @course.lng)

    can_check_in = false

    if lat && lng
      ip_distance = Haversine.distance(lat, lng, @course.lat, @course.lng)
      if front_end_distance.to_meters <= distance_check && ip_distance <= distance_check
        can_check_in = true
      end
    else
      if front_end_distance.to_meters <= distance_check
        can_check_in = true
      end
    end

    render :json => {:status => can_check_in}.to_json


  end
end
