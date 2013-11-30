class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.string :title
      t.string :youtube_id

      t.timestamps
    end
  end
end
