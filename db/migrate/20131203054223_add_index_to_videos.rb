class AddIndexToVideos < ActiveRecord::Migration
  def change
    add_index :videos, [:user_id, :youtube_id], :unique => true
  end
end
