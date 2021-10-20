class AddIndexToTaggings < ActiveRecord::Migration[5.2]
  def change
    add_index(:taggings, :short_url_id)
    add_index(:taggings, :tag_topic_id)
  end
end
