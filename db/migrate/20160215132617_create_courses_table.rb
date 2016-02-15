class CreateCoursesTable < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, limit: 50, null: false, index: true
      t.text :description, null:false

      t.timestamps
    end
  end
end
