class Api::ClassDatesController < ApplicationController

  def show
    @classes = Course.find(params[:id]).class_dates.order(:date)
    render :json => {:classes => @classes}.to_json
  end

end
