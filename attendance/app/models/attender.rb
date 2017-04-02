class Attender < ApplicationRecord
  belongs_to :class_date
  belongs_to :student
end
