class Admin::RelatedImagesController < AdminController
  
  def show_form_item
    #render :inline=> "yo #{params[:id]}"

    @related = RelatedImage.new()
    @related.image_id = params[:id]
          html = render_to_string(
                :partial => "/admin/related_images/related_image.html", 
                :locals => { :related=>@related })
    
    respond_to do |format|

      format.html do 
        render :inline=> html
      end
      format.json do 
            render :json => {
              :html=>html
            } ,:content_type => 'text/json'
      end
    end    
  end
  
  def test_test_form_item 
    #need to redo the code above to populate and clone hidden related_images instead 
    #of ajax getting the fragment. 
    @vendor = Vendor.find(1)
    render :partial => "/admin/related_images/related_image_form_test_test.html", 
                :locals => { :vendor=>@vendor }
  end
end