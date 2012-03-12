require 'spec_helper'

describe "admin_vendors/new.html.erb" do
  before(:each) do
    assign(:vendor, stub_model(Admin::Vendor,
      :name => "MyString",
      :short_description => "MyString",
      :description => "MyText",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new vendor form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => admin_vendors_path, :method => "post" do
      assert_select "input#vendor_name", :name => "vendor[name]"
      assert_select "input#vendor_short_description", :name => "vendor[short_description]"
      assert_select "textarea#vendor_description", :name => "vendor[description]"
      assert_select "input#vendor_url", :name => "vendor[url]"
    end
  end
end
