class ClassDatesController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
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
      @class_pattern.course_id = @class_date.id
      @class_pattern.time = Time.now
    end
    render layout: "no_nav"
  end

  def create
    @class_date = ClassDate.new(class_date_params)
    @class_date.save
    redirect_to class_dates_path(course_id: params[:course_id])
  end

  def update
    @class_date = ClassDate.find(params[:id])
    @class_date.update(class_date_params)
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
