class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string :name
      t.string :short_description
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :vendors
  end
end
