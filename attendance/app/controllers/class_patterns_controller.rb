class ClassPatternsController < ApplicationController
  def create
    @class_pattern = ClassPattern.new(class_pattern_params)
    @class_pattern.save
    @class_pattern.create_class_dates
    puts @class_pattern
    redirect_to class_dates_path(:course_id => @class_pattern.course_id)
  end
  def update
    @class_pattern = ClassPattern.find(params[:id])
    @class_pattern.update(class_pattern_params)
    redirect_to class_dates_path(:course_id => @class_pattern.course_id)
  end
  def destroy
    @class_pattern = ClassPattern.find(params[:id])
  end

  private

  def class_pattern_params
    params.require(:class_pattern).permit(:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :time, :start_date, :end_date, :course_id)
  end

end
