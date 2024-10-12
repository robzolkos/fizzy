class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :bubble, null: false, index: false
      t.references :creator, null: false
      t.json :particulars, default: {}
      t.string :action, null: false

      t.timestamps
    end

    add_index :events, %i[ bubble_id action ], name: "index_events_on_bubble_id_and_action"
  end
end
