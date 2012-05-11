class PagesController < ApplicationController
  
  def home
    @title = "home"
    @last5Vendor = Vendor.find(:all,:order => 'created_at DESC')
    @cats = Category.find(:all,:conditions=>["id in (select distinct c.category_id from 
categories_vendors c, vendors v where v.id = c.vendor_id)"])
  end
  
end
