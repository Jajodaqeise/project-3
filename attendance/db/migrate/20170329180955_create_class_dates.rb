class CreateClassDates < ActiveRecord::Migration[5.0]
  def change
    create_table :class_dates do |t|
      t.belongs_to :course, index: true
      t.timestamp :date
      t.timestamps
    end
  end
end
