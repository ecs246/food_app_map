class AddThumbnailToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :thumbnail, :string
  end

  def self.down
    remove_column :images, :thumbnail
  end
end
