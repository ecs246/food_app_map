class VendorsController < ApplicationController
 layout nil

  def index
    @vendors = Vendor.find(:all)
    respond_to do |format|
      format.json do 
            render :json => @vendors.to_json()
      end
    end
    

  end
  
  def gallery
    
    @vendor = Vendor.find(params[:id],:include=>{:related_images => :image})
    #@related_images = @vendor.related_images
  end
  
  def show
    @vendors = Vendor.find(params[:id])
    respond_to do |format|
      format.json do 
            render :json => @vendors.to_json()
      end
    end
  end
end