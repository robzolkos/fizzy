class AddBoostCountToBubbles < ActiveRecord::Migration[8.0]
  def change
    add_column :bubbles, :boost_count, :integer, null: false, default: 0
  end
end
