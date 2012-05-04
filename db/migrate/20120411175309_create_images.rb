class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.string :short_description
      t.string :url
    end
  end

  def self.down
    drop_table :images
  end
end
