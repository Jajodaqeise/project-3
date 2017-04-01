class Api::ClassDatesController < ApplicationController

  def show
    @classes = Course.find(params[:id]).class_dates.order(:date)
    render :json => {:classes => @classes}.to_json
  end

  def create


    render :json => {:classes => @class_date.course.class_dates}.to_json
  end

  def update
    @class_date = ClassDate.find(params[:id])
    @class_date.update(class_date_params)
    render :json => {:classes => @class_date.course.class_dates, :date => @class_date.date.strftime("%F")}
  end
  def destroy
    @class_date = ClassDate.find(params[:id])
    @classes = @class_date.course.class_dates
    @class_date.delete
    render :json => {:classes => @classes}.to_json
  end

  private

  def class_date_params
    params.require(:class_date).permit(:date, :class_pattern, :repeat)
  end



end
