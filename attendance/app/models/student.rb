class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses
  has_many :attenders

  def attender_percent(course)
    course.past_classes.count == 0 ? 100 : (self.attenders.count / course.past_classes.count) * 100
  end

  def missed_classes(course)
    missed = []
    course.past_classes.each do |past_class|
      unless self.attenders.exists?(:class_date_id => past_class.id)
        missed.pusch(past_class)
      end
    end
  end

  
end
