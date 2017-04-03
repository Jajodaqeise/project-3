class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses
  has_many :attenders

  def course_attenders(course_id)
    course_attenders = []
    self.attenders.each do |attender|
      if attender.class_date.course_id = course_id
        course_attenders.push(attender)
      end
    end
    return course_attenders
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def attender_percent(course_id)
    course = Course.find(course_id)
    percent = course.past_classes.count == 0 ? 100 : ((course_attenders(course_id).count.to_f / course.past_classes.count) * 100)
    return percent
  end

  def missed_classes(course_id)
    course = Course.find(course_id)
    missed = []
    course.past_classes.each do |past_class|
      unless self.attenders.exists?(:class_date_id => past_class.id)
        missed.push(past_class)
      end
    end
  end


end
