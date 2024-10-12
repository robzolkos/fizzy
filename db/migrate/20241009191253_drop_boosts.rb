class DropBoosts < ActiveRecord::Migration[8.0]
  def change
    drop_table :boosts
  end
end
