class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.string :text

      t.references :channel, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
