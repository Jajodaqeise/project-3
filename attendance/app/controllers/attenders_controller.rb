class AttendersController < ApplicationController
  geocode_ip_address
  before_action :require_user
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

    distance_check = 60

    @course = ClassDate.find(params[:class_date_id]).course

    lat = params[:student_lat].to_f
    lng = params[:student_lng].to_f

    distance = Haversine.distance(lat, lng, @course.lat, @course.lng)
    meters = distance.to_meters

    if meters <= distance_check
      @attender = Attender.new
      @attender.class_date = ClassDate.find(params[:class_date_id])
      @attender.student_id = params[:student_id]
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
