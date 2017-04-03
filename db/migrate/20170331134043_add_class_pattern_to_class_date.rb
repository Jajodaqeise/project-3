class AddClassPatternToClassDate < ActiveRecord::Migration[5.0]
  def change
    add_reference :class_dates, :class_pattern, index: true
    add_foreign_key :class_dates, :class_patterns
    add_column :class_dates, :repeat, :bool, default: false
  end
end
