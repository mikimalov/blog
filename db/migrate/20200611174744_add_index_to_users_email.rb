class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :Users, :email, unique: true
  end
end
