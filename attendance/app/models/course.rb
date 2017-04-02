class Course < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :teacher
  has_many :class_dates
  has_many :class_patterns
  acts_as_mappable
  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
  def past_classes
    self.class_dates.where("date < ?", Time.now)
  end
end
