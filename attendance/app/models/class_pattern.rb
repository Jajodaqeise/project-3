class ClassPattern < ApplicationRecord
  belongs_to :course
  has_many :class_dates

  def create_class_dates
   seconds_per_day = 24*60*60
   end_day = self.end_date.change(hour: self.time.strftime("%H").to_i, min: self.time.strftime("%M").to_i).to_i
   tracked_day = self.start_date.change(hour: self.time.strftime("%H").to_i, min: self.time.strftime("%M").to_i).to_i

     while tracked_day <= end_day do
       date = DateTime.strptime(tracked_day.to_s,'%s')
       day_of_week = date.strftime("%A")

       if self[day_of_week.downcase.to_sym]
         puts day_of_week
         class_date = ClassDate.new(:course_id => self.course_id, :date => date, :repeat => true, :class_pattern_id => self.id)
         class_date.save
       end
       tracked_day = tracked_day + seconds_per_day
     end
  end

  def update_class_dates

  end

end
