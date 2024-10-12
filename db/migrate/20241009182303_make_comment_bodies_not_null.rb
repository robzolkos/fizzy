class MakeCommentBodiesNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :comments, :body, false
  end
end
