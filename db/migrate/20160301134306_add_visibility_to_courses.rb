class AddVisibilityToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :visible, :boolean, null: false, default: true
  end
end
