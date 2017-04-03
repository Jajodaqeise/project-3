class AddStartAndEndDatesToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :start_date, :timestamp
    add_column :courses, :end_date, :timestamp
  end
end
