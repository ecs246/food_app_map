class Admin::VendorsController < AdminController
  # GET /admin/vendors
  # GET /admin/vendors.xml
  def index
    @vendors = Vendor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendors }
    end
  end

  
  # GET /admin/vendors/1
  # GET /admin/vendors/1.xml
  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendor }
    end
  end

  # GET /admin/vendors/new
  # GET /admin/vendors/new.xml
  def new
    @vendor = Vendor.new
   @images = Image.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendor }
    end
  end

  # GET /admin/vendors/1/edit
  def edit
    @vendor = Vendor.includes([:related_images,:images]).find(params[:id])
    @images = Image.find(:all)
  end

  # POST /admin/vendors
  # POST /admin/vendors.xml
  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to([:admin,@vendor], :notice => 'Vendor was successfully created.') }
        format.xml  { render :xml => [:admin,@vendor], :status => :created, :location => @vendor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/vendors/1
  # PUT /admin/vendors/1.xml
  def update
    @vendor = Vendor.find(params[:id])
  
    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.html { redirect_to([:admin,@vendor] ,:notice => 'Vendor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/vendors/1
  # DELETE /admin/vendors/1.xml
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to(admin_vendors_url) }
      format.xml  { head :ok }
    end
  end
end
