class ChangeUserPassword < ActiveRecord::Migration
  def change
    add_column :students, :password_digest, :string
    remove_column :sessions, :email, :string
    remove_column :sessions, :password_digest, :string
  end
end