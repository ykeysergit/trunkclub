class AddWorkflowStateToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :workflow_state, :string
  end
end
