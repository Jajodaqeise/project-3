class AttendersController < ApplicationController
  def create
    @student = params
    byebug
    # @attender = Attender.new()
    # if @attender.save
    #   # byebug
    #     flash[:notice] = "Checked in successfully!"
    #     # redirect_back fallback_location: course_path
    #     puts @attender
    # else
    #     flash[:alert] = "Make sure you are in the right location"
    #     # redirect_back fallback_location: course_path
    # end
  end

# private

#   def attender_params
#     # params.require(:attender).permit(:student_id, :class_date_id)
#     params.require(:attender).permit(:student_id)
#   end
end
