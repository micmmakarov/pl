class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :user_id
      t.string :integer
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
