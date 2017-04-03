class AttendersController < ApplicationController
  geocode_ip_address
  before_action :require_user
  before_action :require_teacher, only: [:index]
  before_action :require_student, only: [:create]

  def index
    @course = Course.find(params[:course_id])
    @students = @course.students
    render layout: "nav"
  end

  def show
    @course = Course.find(params[:course_id])

      unless (current_student && params[:student_id].to_i == current_student.id) || (current_teacher && @course.teacher_id == current_teacher.id)
        byebug
        redirect_to courses_path
      end

    @student = Student.find(params[:student_id])

    @class_dates = @course.past_classes.order(:date)
    @attendances = []
    @class_dates.each do |class_date|
      attendance = @student.attenders.exists?(:class_date_id => class_date.id) ? true : false
      @attendances << {
        :date => class_date.date,
        :attendance => attendance
      }
    end

    @percent = @student.attender_percent(@course.id)
    @color_green = ((@percent / 100) * 255).to_i
    @color_red = 255 - @color_green

    render layout: "nav"
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
