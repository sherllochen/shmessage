class CreateShmessageMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :shmessage_messages do |t|
      t.string :title, null: false
      t.text :body
      t.integer :author_id, null: false

      t.timestamps
    end
    add_index :shmessage_messages, :author_id
  end
end
