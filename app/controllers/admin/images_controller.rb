class Admin::ImagesController < AdminController
  # GET /admin/images
  # GET /admin/images.xml
  def index
    @images = nil;
    if params[:search] == "" then
      @images = Image.all
    else
      search = "%#{params[:search]}%"
      @images = Image.find(:all,:conditions=>['lower(name) like ?',search.downcase])
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
      format.json {
          
           render :text=> @images.to_json(:methods => :thumbnail)
        }
    end
  end

  # GET /admin/images/1
  # GET /admin/images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/images/new
  # GET /admin/images/new.xml
  def new
    @image = Image.new
   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /admin/images
  # POST /admin/images.xml
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to([:admin,@image], :notice => 'Image was successfully created.') }
        format.xml  { render :xml => [:admin,@image], :status => :created, :location => @image }
        format.json   do 
          render :json=> @image,
          :content_type => 'text/json',
          :status => :created          
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        format.json { render :status=>:unprocessable_entity ,:json => @image.errors, :content_type => 'text/json' }

      end
    end
  end

  # PUT /admin/images/1
  # PUT /admin/images/1.xml
  def update
    @image = Image.find(params[:id])
  
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to([:admin,@image] ,:notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/images/1
  # DELETE /admin/images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_images_url) }
      format.xml  { head :ok }
    end
  end
end
