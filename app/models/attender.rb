class Attender < ApplicationRecord
  validates :class_date_id, presence: true
  validates :student_id, presence: true

  belongs_to :class_date
  belongs_to :student
end
