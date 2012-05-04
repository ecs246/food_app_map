class CreateRelatedImagesTable < ActiveRecord::Migration
  def self.up
    create_table :related_images do |t|
      t.integer :vendor_id
      t.integer :image_id
      t.integer :rank
      t.string :alt_title
      t.text :alt_description
    end
  end

  def self.down
    drop_table :related_images
  end
end
