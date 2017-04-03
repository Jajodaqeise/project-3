class ChangeAttenderRefferenceToClassToClassDate < ActiveRecord::Migration[5.0]
  def change
    rename_column :attenders, :class_id, :class_date_id
  end
end
