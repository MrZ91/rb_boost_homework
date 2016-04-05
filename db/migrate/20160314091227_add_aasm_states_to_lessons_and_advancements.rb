class AddAasmStatesToLessonsAndAdvancements < ActiveRecord::Migration
  def change
    add_column :lessons, :state, :string
    add_index  :lessons, :state
    add_column :advancements, :state, :string
    add_index  :advancements, :state
  end
end
