class AddExtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ext, :integer
  end
end
