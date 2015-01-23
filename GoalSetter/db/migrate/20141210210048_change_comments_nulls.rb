class ChangeCommentsNulls < ActiveRecord::Migration
  def change
    change_column_null :comments, :body, false
    change_column_null :comments, :commentable_id, false
    change_column_null :comments, :commentable_type, false
    change_column_null :goals, :user_id, false
  end
end
