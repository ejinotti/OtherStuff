class AddAuthorToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_id, :integer
    change_column_null :comments, :author_id, false
  end
end
