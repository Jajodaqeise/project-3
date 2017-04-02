class ClassDate < ApplicationRecord
  belongs_to :course
  has_many :attenders
  has_one :class_pattern

  def pattern
    self.class_pattern_id ? ClassPattern.find(self.class_pattern_id) : nil
  end

end
