class RemoveAssignmentsIndexOnAssigneeId < ActiveRecord::Migration[8.0]
  def change
    remove_index :assignments, :assignee_id
  end
end
