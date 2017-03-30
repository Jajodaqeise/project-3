class Api::FindClassesController < ApplicationController
  def index
  end
  def create
    month = params[:month]
    year = params[:year]
    course = Course.find(params[:course_id])
    
  end
end
