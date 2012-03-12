class Admin::CategoriesController < AdminController
  # GET /admin/categories
  # GET /admin/categories.xml
  
  def index
    @categories = Category.find_all_by_parent_id(nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html do 
        if request.xhr?
          render
        else
          
          #render :inline  => {:html=>varb}.to_json
          render :json => {
              :html=>render_to_string(:partial => "item", :locals => { :level => @category.parents_array.size, :category=>@category }),
              :category=>@category.attributes
            }

        end
      end
      format.xml  { render :xml => @category }
      format.json {render :json=> @category, :content_type => 'text/json'}
    end
  end

  # GET /admin/categories/new
  # GET /admin/categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /admin/categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /admin/categories
  # POST /admin/categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to([:admin,@category], :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
        format.json   do 
        level =  @category.parents_array.size
        varb = render_to_string :partial => "item.html.erb",:locals => { :level => level, :category=>@category }
        #varb = ""
          render :json => {
              :html=>varb,
              :category=>@category.attributes,
              :level => level
              
            }, 
            :content_type => 'text/json',
            :status => :created
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        format.json { render :status=>:unprocessable_entity ,:json => @category.errors, :content_type => 'text/json' }
      end
    end
  end

  # PUT /admin/categories/1
  # PUT /admin/categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to([:admin,@category] ,:notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_categories_url) }
      format.xml  { head :ok }
    end
  end
end
