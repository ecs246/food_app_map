class CreateVendorCategoryJoinTable < ActiveRecord::Migration
  def self.up
    create_table :categories_vendors, :id => false do |t|
      t.integer :vendor_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :categories_vendors
  end
end
