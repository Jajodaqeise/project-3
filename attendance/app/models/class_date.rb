class ClassDate < ApplicationRecord
  validates :date, presence: true
  validates :course_id, presence: true

  belongs_to :course
  has_many :attenders
  has_one :class_pattern

  def pattern
    self.class_pattern_id ? ClassPattern.find(self.class_pattern_id) : nil
  end

end
