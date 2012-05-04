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
  
end