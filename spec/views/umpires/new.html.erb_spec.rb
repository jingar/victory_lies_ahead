require 'spec_helper'

describe "umpires/new" do
  before(:each) do
    assign(:umpire, stub_model(Umpire,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => ""
    ).as_new_record)
  end

  it "renders new umpire form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => umpires_path, :method => "post" do
      assert_select "input#umpire_first_name", :name => "umpire[first_name]"
      assert_select "input#umpire_last_name", :name => "umpire[last_name]"
      assert_select "input#umpire_email", :name => "umpire[email]"
    end
  end
end
