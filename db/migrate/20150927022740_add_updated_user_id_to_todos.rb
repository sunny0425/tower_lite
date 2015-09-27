class AddUpdatedUserIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :updated_user_id, :integer
  end
end
