class AddIsDeletedToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :is_deleted, :boolean, default: false
  end
end
