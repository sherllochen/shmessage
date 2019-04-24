class CreateShmessageUserReadMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :shmessage_user_read_messages do |t|
      t.integer :user_id, null: false
      t.integer :message_id, null: false

      t.timestamps
    end

    add_index :shmessage_user_read_messages, :user_id
    add_index :shmessage_user_read_messages, :message_id
  end
end
