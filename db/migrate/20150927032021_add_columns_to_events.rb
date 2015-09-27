class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :project_id, :integer
    add_column :events, :team_id, :integer
    add_index :events, :project_id
    add_index :events, :team_id
  end
end
