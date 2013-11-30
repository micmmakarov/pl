class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
    add_index :votes, [:user_id, :video_id], :unique => true
  end
end
