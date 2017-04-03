class CreateClassPattern < ActiveRecord::Migration[5.0]
  def change
    create_table :class_patterns do |t|
      t.belongs_to :course
      t.boolean :monday, default: false
      t.boolean :tuesday, default: false
      t.boolean :wednesday, default: false
      t.boolean :thursday, default: false
      t.boolean :friday, default: false
      t.boolean :saturday, default: false
      t.boolean :sunday, default: false
      t.timestamp :start_date
      t.timestamp :end_date
      t.timestamp :time
    end

    remove_column :courses, :sunday
    remove_column :courses, :monday
    remove_column :courses, :tuesday
    remove_column :courses, :wednesday
    remove_column :courses, :thursday
    remove_column :courses, :friday
    remove_column :courses, :saturday
    remove_column :courses, :time
  end
end
