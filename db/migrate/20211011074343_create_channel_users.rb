class CreateChannelUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :channel_users do |t|
      t.references :channel, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps null: false

      t.index %i[channel_id user_id], unique: true
    end
  end
end
