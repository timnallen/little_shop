class ChangeUserPasswordToPasswordDigest < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password, :password_digest
    remove_column :users, :role
    add_column :users, :role, :integer, default: 0
  end

  # Unable to convert column type of string in to integer for auth
  # Drops column and re adds to convert to enum format following lesson
end
