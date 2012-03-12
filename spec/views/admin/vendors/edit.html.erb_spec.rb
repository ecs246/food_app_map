require 'spec_helper'

describe "admin_vendors/edit.html.erb" do
  before(:each) do
    @vendor = assign(:vendor, stub_model(Admin::Vendor,
      :new_record? => false,
      :name => "MyString",
      :short_description => "MyString",
      :description => "MyText",
      :url => "MyString"
    ))
  end

  it "renders the edit vendor form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => vendor_path(@vendor), :method => "post" do
      assert_select "input#vendor_name", :name => "vendor[name]"
      assert_select "input#vendor_short_description", :name => "vendor[short_description]"
      assert_select "textarea#vendor_description", :name => "vendor[description]"
      assert_select "input#vendor_url", :name => "vendor[url]"
    end
  end
end
