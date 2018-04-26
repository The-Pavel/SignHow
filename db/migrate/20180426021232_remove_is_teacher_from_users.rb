class RemoveIsTeacherFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_teacher, :boolean
  end
end
