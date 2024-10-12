class AddUniqueIndexToAssignments < ActiveRecord::Migration[8.0]
  def change
    add_index :assignments, %i[ assignee_id bubble_id ], unique: true
  end
end
