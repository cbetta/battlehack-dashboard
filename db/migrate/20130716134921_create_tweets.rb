class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :xid
      t.string :name
      t.string :screen_name
      t.text :text
      t.text :media_url
      t.text :profile_image_url
      t.datetime :tweeted_at

      t.timestamps
    end
  end
end
