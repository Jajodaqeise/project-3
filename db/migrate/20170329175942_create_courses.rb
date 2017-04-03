class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :school
      t.string :description
      t.belongs_to :teacher, index: true
      t.decimal :lat
      t.decimal :lng 
      t.timestamps
    end
  end
end
