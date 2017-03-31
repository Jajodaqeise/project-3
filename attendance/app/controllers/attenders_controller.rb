class AttendersController < ApplicationController
  def create
    @attender = Attender.new(attender_params)
    if @attender.save
      byebug
        flash[:notice] = "Checked in successfully!"
        # redirect_back fallback_location: course_path
        puts @attender
    else
        flash[:alert] = "Make sure you are in the right location"
        # redirect_back fallback_location: course_path
    end
  end

private

  def attender_params
    # params.require(:attender).permit(:student_id, :class_date_id)
    params.require(:attender).permit(:student_id)
  end
end
