class Course < ApplicationRecord
  validates :name, presence: true
  validates :school, presence: true
  validates :description, presence: true
  validates :teacher, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  has_and_belongs_to_many :students
  belongs_to :teacher
  has_many :class_dates
  has_many :class_patterns
  acts_as_mappable
  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
