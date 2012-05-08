class Admin::ImageUtilityController < AdminController
  include Admin::ImageUtilityHelper
  
  def index
    @flick = XMLFlickrObj.new(:numItems=>30)
    
  end

 
  # POST /admin/categories
  # POST /admin/categories.xml
  def create
 
  end

 


end
