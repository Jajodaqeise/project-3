class Course < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :teacher
  has_many :class_dates
  has_many :class_patterns
end
