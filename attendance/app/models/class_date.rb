class ClassDate < ApplicationRecord
  belongs_to :course
  has_many :attenders
end
