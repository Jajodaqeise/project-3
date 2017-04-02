class AttendersController < ApplicationController
  before_action :require_user
<<<<<<< HEAD
=======

>>>>>>> 0bfd779e14fb146ad23bb485cbcf6be7a302d6b5
  before_action :require_teacher, only: [:index]
  before_action :require_student, only: [:create]

  def index
    @course = Course.find(params[:course_id])
    @students = @course.students
  end

  def show
    @course = Course.find(params[:course_id])
    @student = Student.find(params[:student_id])
    @attenders = @student.attenders.order(:date)
  end


  def create

    distance_check = 80

    @course = ClassDate.find(params[:attender][:class_date_id]).course

    lat = params[:student_lat].to_f
    lng = params[:student_lng].to_f

    distance = Haversine.distance(lat, lng, @course.lat, @course.lng)
    meters = distance.to_meters

    if meters <= distance_check
      @attender = Attender.new(attender_params)
      @attender.save
      flash[:notice] = "Checked in successfully!"
      redirect_back fallback_location: course_path(@course)
    else
        flash[:alert] = "Make sure you are in the right location"
        redirect_back fallback_location: course_path(@course)
    end
  end

private

  def attender_params
    params.require(:attender).permit(:student_id, :class_date_id)
  end
end
