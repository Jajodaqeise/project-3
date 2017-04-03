class ClassDatesController < ApplicationController
  before_action :require_user
  before_action :require_teacher
  def index
    @course = Course.find(params[:course_id])
    render layout: "nav"
  end
 
  def new
    @course = Course.find(params[:course_id])
    @class_pattern = ClassPattern.new
    @class_pattern.course_id = @course.id
    @class_pattern.start_date = @course.start_date
    @class_pattern.end_date = @course.end_date
    @classes = @course.class_dates.order(:date)
    @class_date = ClassDate.new
    @class_date.course_id = @course.id

    render layout: "no_nav"
  end

  def edit
    @class_date = ClassDate.find(params[:id])
    @class_pattern = @class_date.pattern
    if(!@class_pattern)
      @class_pattern = ClassPattern.new
      @class_pattern.start_date = @class_date.date
      @class_pattern.course_id = @class_date.course_id
      @class_pattern.time = Time.now
    end
    render layout: "no_nav"
  end

  def create
    @class_date = ClassDate.new(class_date_params)
    time = params[:class_date][:time].split(":")
    @class_date.date = @class_date.date.change(hour: time[0], min: time[1])
    @class_date.date += params[:timezone_offset].to_i * 60
    @class_date.save
    redirect_to class_dates_path(course_id: params[:course_id])
  end

  def update
    @class_date = ClassDate.find(params[:id])
    datetime = @class_date.date
    @class_date.update(class_date_params)
    repeat = @class_date.repeat
    if repeat && params[:class_date][:repeat] == "0"
      class_pattern_id = @class_date.class_pattern_id
      @class_date.class_pattern_id = nil
      @class_date.save
      ClassDate.where(:class_pattern_id => class_pattern_id).delete_all
      ClassPattern.find(class_pattern_id).delete
    end

    time = params[:class_date][:time].split(":")
    @class_date.date = @class_date.date.change(hour: time[0], min: time[1])
    @class_date.date += params[:timezone_offset].to_i * 60
    @class_date.save



    if repeat && datetime.to_i != @class_date.date.to_i
      @class_date.repeat = false
      @class_date.class_pattern_id = nil
      @class_date.save
    end

    redirect_to class_dates_path(:course_id => @class_date.course_id)
  end

  def destroy
    @class_date = ClassDate.find(params[:id])
    @course = @class_date.course
    @class_date.delete
    redirect_to class_dates_path(:course_id => @course.id)
  end

  private

  def class_date_params
    params.require(:class_date).permit(:date, :class_pattern, :repeat, :course_id)
  end


end
