require 'spec_helper'

describe Admin::VendorsController do

  def mock_vendor(stubs={})
    (@mock_vendor ||= mock_model(Admin::Vendor).as_null_object).tap do |vendor|
      vendor.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all admin_vendors as @admin_vendors" do
      Admin::Vendor.stub(:all) { [mock_vendor] }
      get :index
      assigns(:admin_vendors).should eq([mock_vendor])
    end
  end

  describe "GET show" do
    it "assigns the requested vendor as @vendor" do
      Admin::Vendor.stub(:find).with("37") { mock_vendor }
      get :show, :id => "37"
      assigns(:vendor).should be(mock_vendor)
    end
  end

  describe "GET new" do
    it "assigns a new vendor as @vendor" do
      Admin::Vendor.stub(:new) { mock_vendor }
      get :new
      assigns(:vendor).should be(mock_vendor)
    end
  end

  describe "GET edit" do
    it "assigns the requested vendor as @vendor" do
      Admin::Vendor.stub(:find).with("37") { mock_vendor }
      get :edit, :id => "37"
      assigns(:vendor).should be(mock_vendor)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created vendor as @vendor" do
        Admin::Vendor.stub(:new).with({'these' => 'params'}) { mock_vendor(:save => true) }
        post :create, :vendor => {'these' => 'params'}
        assigns(:vendor).should be(mock_vendor)
      end

      it "redirects to the created vendor" do
        Admin::Vendor.stub(:new) { mock_vendor(:save => true) }
        post :create, :vendor => {}
        response.should redirect_to(admin_vendor_url(mock_vendor))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vendor as @vendor" do
        Admin::Vendor.stub(:new).with({'these' => 'params'}) { mock_vendor(:save => false) }
        post :create, :vendor => {'these' => 'params'}
        assigns(:vendor).should be(mock_vendor)
      end

      it "re-renders the 'new' template" do
        Admin::Vendor.stub(:new) { mock_vendor(:save => false) }
        post :create, :vendor => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested vendor" do
        Admin::Vendor.should_receive(:find).with("37") { mock_vendor }
        mock_admin_vendor.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vendor => {'these' => 'params'}
      end

      it "assigns the requested vendor as @vendor" do
        Admin::Vendor.stub(:find) { mock_vendor(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:vendor).should be(mock_vendor)
      end

      it "redirects to the vendor" do
        Admin::Vendor.stub(:find) { mock_vendor(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_vendor_url(mock_vendor))
      end
    end

    describe "with invalid params" do
      it "assigns the vendor as @vendor" do
        Admin::Vendor.stub(:find) { mock_vendor(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:vendor).should be(mock_vendor)
      end

      it "re-renders the 'edit' template" do
        Admin::Vendor.stub(:find) { mock_vendor(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested vendor" do
      Admin::Vendor.should_receive(:find).with("37") { mock_vendor }
      mock_admin_vendor.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_vendors list" do
      Admin::Vendor.stub(:find) { mock_vendor }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_vendors_url)
    end
  end

end
