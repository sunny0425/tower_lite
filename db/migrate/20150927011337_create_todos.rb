class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :desc
      t.integer :creator_id
      t.integer :assignee_id
      t.date :end_date
      t.boolean :is_done, default: false

      t.timestamps null: false
    end
  end
end
