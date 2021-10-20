class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.integer "user_id", null: false
      t.string "short_url"
      t.string "long_url"
      t.timestamps
    end
  end
end
