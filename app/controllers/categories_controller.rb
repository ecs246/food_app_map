class CategoriesController < ApplicationController
 
 def vendors
   category = Category.find(params[:id])
   vendors = category.vendors
    respond_to do |format|
      format.json do 
            render :json => vendors.to_json()
      end
    end
 end
  
end
