class ClassDatesController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @classes = @course.class_dates.order(:date)
  end
  def create
  end
  def update
  end
  def destroy
  end
end
