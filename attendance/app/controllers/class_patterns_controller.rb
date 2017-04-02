class ClassPatternsController < ApplicationController
  before_action :set_days, only: [:create, :update]
  def create
    @class_pattern = ClassPattern.new(class_pattern_params)
    @class_pattern.time += params[:class_pattern][:timezone_offset].to_i *60
    @class_pattern.save
    @class_pattern.add_class_date_range(@days, @class_pattern.time, @class_pattern.start_date, @class_pattern.end_date)
    puts @class_pattern.course_id
    redirect_to class_dates_path(:course_id => @class_pattern.course_id)
  end
  def update
    @class_pattern = ClassPattern.find(params[:id])
    @new_pattern = ClassPattern.new(class_pattern_params)
    @new_pattern.time += params[:class_pattern][:timezone_offset].to_i *60
    @class_pattern.update_class_dates(@days, @new_pattern)
    @class_pattern.update(class_pattern_params)
    redirect_to class_dates_path(:course_id => @class_pattern.course_id)
  end
  def destroy
    @class_pattern = ClassPattern.find(params[:id])
    course_id = @class_pattern.course_id
    ClassDate.where(:class_pattern_id => @class_pattern.id).delete_all
    @class_pattern.delete
    redirect_to class_dates_path(:course_id => course_id)
  end

  private

  def class_pattern_params
    params.require(:class_pattern).permit(:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :time, :start_date, :end_date, :course_id)
  end

  def set_days
    days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    @days = {}
    days.each do |day|
      @days[day.to_sym] = params[:class_pattern][day.to_sym]
    end
  end

end
