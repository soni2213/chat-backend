class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
