class AddLocationToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :address, :text
    add_column :vendors, :latitude, :float
    add_column :vendors, :longitude, :float
            
  end

  def self.down
    remove_column :vendors, :address
    remove_column :vendors, :latitude
    remove_column :vendors, :longitude
  end
end
