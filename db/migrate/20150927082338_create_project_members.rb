class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :role, default: ProjectMember::roles[:normal]

      t.timestamps null: false
    end
  end
end
