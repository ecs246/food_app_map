require 'spec_helper'

describe "admin_vendors/index.html.erb" do
  before(:each) do
    assign(:admin_vendors, [
      stub_model(Admin::Vendor,
        :name => "Name",
        :short_description => "Short Description",
        :description => "MyText",
        :url => "Url"
      ),
      stub_model(Admin::Vendor,
        :name => "Name",
        :short_description => "Short Description",
        :description => "MyText",
        :url => "Url"
      )
    ])
  end

  it "renders a list of admin_vendors" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Short Description".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
