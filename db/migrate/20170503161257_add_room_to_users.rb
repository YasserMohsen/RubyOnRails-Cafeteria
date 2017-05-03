class AddRoomToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :room
    add_foreign_key :users, :rooms
  end
end
