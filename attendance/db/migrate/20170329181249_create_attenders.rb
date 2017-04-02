class CreateAttenders < ActiveRecord::Migration[5.0]
  def change
    create_table :attenders do |t|
      t.belongs_to :student, index: true
      t.belongs_to :class, index: true
      t.timestamps
    end
  end
end
