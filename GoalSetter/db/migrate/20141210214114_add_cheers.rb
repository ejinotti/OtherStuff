class AddCheers < ActiveRecord::Migration
  def change
    add_column :users, :cheers, :integer, default: 10
    add_column :goals, :cheers, :integer, default: 0
  end
end
