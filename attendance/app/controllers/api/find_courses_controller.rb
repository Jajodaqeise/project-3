class Api::FindCoursesController < ApplicationController

  def index

  end

  def create
    puts params[:data]

    @courses = Course.search(params[:data]).order("created_at DESC")

    respond_to do |format|
      format.json { render json: @courses }
    end
  end


end
