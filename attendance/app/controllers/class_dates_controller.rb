class ClassDatesController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @classes = @course.class_dates.order(:date)
  end
  def create
    @course = Course.find(params[:course_id])
    week_days = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    week_days.each do |day|
      @course[day.to_sym] = params[day.to_sym] == "1" ? true : false
      puts @course[day.to_sym]
    end
    time = params[:time].split(":")
    @course[:time] = @course.start_date.change(hour: time[0].to_i, min: time[1].to_i)

    if (!@course.save)
      flash[:alert] = "Could not add schedule!"
      redirect_to new_class_date_path(:course_id => @course.id)
    end

    @course.class_dates.each do |class_date|
      class_date.destroy
    end

    seconds_per_day = 24*60*60

    end_day = @course.end_date.change(hour: time[0].to_i, min: time[1].to_i).to_i
    tracked_day = @course.time.to_i

    adding = true

    while tracked_day <= end_day && adding do
      date = DateTime.strptime(tracked_day.to_s,'%s')
      day_of_week = date.strftime("%A")

      if @course[day_of_week.downcase.to_sym]
        puts day_of_week
        class_date = ClassDate.new(:course_id => @course.id, :date => date)
        if (!class_date.save)
          adding = false
          puts "error saving class date"
        end

      end
      tracked_day = tracked_day + seconds_per_day
    end
    puts ClassDate.all.inspect


  end
  def update
  end
  def destroy
  end

  private
end
