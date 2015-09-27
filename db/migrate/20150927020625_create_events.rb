class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :activist_id
      t.integer :activity_type
      t.string :content
      t.integer :eventable_id
      t.string :eventable_type

      t.timestamps null: false
    end
  end
end
