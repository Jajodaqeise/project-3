class ClassPattern < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :time, presence: true
  validates :course_id, presence: true

  belongs_to :course
  has_many :class_dates

  def add_class_date_range(days, time, start_date, end_date)
    seconds_per_day = 24*60*60
    end_day = end_date.change(hour: time.strftime("%H").to_i, min: time.strftime("%M").to_i).to_i
    tracked_day = start_date.change(hour: time.strftime("%H").to_i, min: time.strftime("%M").to_i).to_i

      while tracked_day <= end_day do
        date = DateTime.strptime(tracked_day.to_s,'%s')
        day_of_week = date.strftime("%A")

        if days[day_of_week.downcase.to_sym] == "1" && !self.class_dates.exists?(:date => date)
          class_date = ClassDate.new(:course_id => self.course_id, :date => date, :repeat => true, :class_pattern_id => self.id)
          class_date.save
        end
        tracked_day = tracked_day + seconds_per_day
      end
  end

  # http://stackoverflow.com/questions/2381718/rails-activerecord-date-between
  def remove_class_dates_before(date)
    class_dates = self.class_dates.where("date < ?", date.beginning_of_day)
    class_dates.delete_all
  end

  def remove_class_dates_after(date)
    class_dates = self.class_dates.where("date > ?", date.end_of_day)
    class_dates.delete_all
  end

  def remove_class_dates_on_day_of_week(day)
    class_dates = self.class_dates
    class_dates.each do |class_date|
      if class_date.date.strftime("%A").downcase == day
        class_date.delete
      end
    end
  end

  def update_class_dates(days, pattern)
    week_days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    if self.start_date.beginning_of_day < pattern.start_date.beginning_of_day
      remove_class_dates_before(pattern.start_date)
    end
    if self.end_date.end_of_day > pattern.end_date.end_of_day
      remove_class_dates_after(pattern.end_date)
    end

    new_days = {}
    has_new_days = false

    extend_days = {}
    extending_days_start = false
    extending_days_end = false
    week_days.each do |day|

      if self[day.to_sym] && days[day.to_sym] == "0"
        remove_class_dates_on_day_of_week(day)
      elsif !self[day.to_sym] && days[day.to_sym] == "1"
        has_new_days = true
        new_days[day.to_sym] = days[day.to_sym]
      end

      if self[day.to_sym] && days[day.to_sym] == "1"

        if self.start_date.beginning_of_day > pattern.start_date.beginning_of_day
          extend_days_start = true
        end

        if self.end_date.end_of_day < pattern.end_date.end_of_day
          extending_days_end = true
        end

        if extending_days_end || extending_days_start
          extend_days[day.to_sym] = days[day.to_sym]
        end

      end

    end

    if self.time.strftime("%H:%M") != pattern.time.strftime("%H:%M")
      self.class_dates.each do |class_date|
        class_date.date = class_date.date.change(hour: pattern.time.strftime("%H").to_i, min: pattern.time.strftime("%M").to_i)
        class_date.save
      end
    end

    if has_new_days
      add_class_date_range(new_days, pattern.time, pattern.start_date, pattern.end_date)
    end

    if extending_days_start
      add_class_date_range(extend_days, pattern.time, pattern.start_date, self.start_date)
    end

    if extending_days_end
      add_class_date_range(extend_days, pattern.time, self.end_date, pattern.end_date)
    end

  end


end
