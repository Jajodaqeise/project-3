class Course < ApplicationRecord
  has_many :students
  belongs_to :teacher
  has_many :class_dates
  has_many :class_patterns
end
