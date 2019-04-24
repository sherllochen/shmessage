class AddTargetRoleToShmessageMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :shmessage_messages, :target_role, :string, default: ''
    add_index :shmessage_messages, :target_role
  end
end
