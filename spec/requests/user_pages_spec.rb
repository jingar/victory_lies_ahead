require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, first_name: "Bob", last_name: "jay", email: "bob@example.com",
        address: "blah blah 1", telephone: "121212", sport:"hurdles")

      FactoryGirl.create(:user, first_name: "Ben", last_name: "hoho",  email: "ben@example.com",
        address: "blah blah 2", telephone: "121212", sport:"wattball")
      visit users_path
    end

    it { should have_selector('title'), text: 'All users' }
    it { should have_selector('h1'), text: 'All users' }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li'), text: user.first_name
        page.should have_selector('li'), text: user.last_name
      end
    end
  end
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1'),    text: 'Sign up' }
    it { should have_selector('title'), text: full_title('Sign up') }
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	
    it { should have_selector('h1'), text: user.first_name, text: user.last_name }
    it { should have_selector('title'), text: user.first_name }
  end

  describe "sign up" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information - wattball" do
      before do
        fill_in "First name", with: "Saad"
        fill_in "Last name", with: "Arif"
        fill_in "Email", with: "saadarif006@gmail.com"
        fill_in "Address", with: "39 Woshington road"
        fill_in "Telephone", with: "078456899"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
        select 'Hurdles', :from => 'user[sport]'
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
    
    describe "with valid information - hurdles" do
      before do
        fill_in "First name", with: "Arif"
        fill_in "Last name", with: "Saad"
        fill_in "Email", with: "saadarif005@gmail.com"
        fill_in "Address", with: "39 Washington road"
        fill_in "Telephone", with: "078456889"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
        select 'Wattball', :from => 'user[sport]'
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1'), text: "Update your profile" }
      it { should have_selector('title'), text: "Edit user" }
      it { should have_link('change'), href: 'http://gravatar.com/emails' }
    end

    describe "with valid information" do
      let(:new_first_name) { "New" }
      let(:new_last_name) { "Name" }
      let(:new_email) { "new@example.com" }
      let(:new_address) {"123 address example"}
      let(:new_telephone) {"0143 1245454"}
      before do
        fill_in "First name", with: new_first_name
        fill_in "Last name", with: new_last_name
        fill_in "Email", with: new_email
        fill_in "Address", with: new_address
        fill_in "Telephone", with: new_telephone
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title'), text: new_first_name }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out'), href: signout_path }
      specify { user.reload.first_name.should == new_first_name }
      specify { user.reload.last_name.should == new_last_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "Authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title'), text: 'Sign in' }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
end
