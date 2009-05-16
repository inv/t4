class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :status_id
      t.string :text
      t.string :source
      t.boolean :truncated
      t.integer :in_reply_to_status_id
      t.integer :in_reply_to_user_id
      t.boolean :favorited
      t.string :in_reply_to_screen_name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
