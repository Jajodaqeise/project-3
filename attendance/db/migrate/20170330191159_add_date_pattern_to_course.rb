class AddDatePatternToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :sunday, :bool, default: false
    add_column :courses, :monday, :bool, default: false
    add_column :courses, :tuesday, :bool, default: false
    add_column :courses, :wednesday, :bool, default: false
    add_column :courses, :thursday, :bool, default: false
    add_column :courses, :friday, :bool, default: false
    add_column :courses, :saturday, :bool, default: false
    add_column :courses, :time, :timestamp
  end
end
