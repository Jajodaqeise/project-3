class Api::FindClassesController < ApplicationController
  def index
    classes = Course.find(params[:course_id]).class_dates.order(:date)
    render :json => {:classes => classes}.to_json
  end
  def create
  end
  def update
    @class_date = ClassDate.find(params[:id])
    time = params[:time].split(":")
    @class_date.date = params[:date]
    @class_date.date = DateTime.strptime(@class_date.date.change(hour: time[0].to_i, min: time[1].to_i).to_i.to_s,'%s')
    @class_date.save


    render :json => {:classes => ClassDate.all, :date => params[:date]}
  end
  def destroy
  end
end
