# == Schema Information
#
# Table name: staffs
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  position        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_name       :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe Staff do
    let(:found_staff) { Staff.find_by_first_name(@staff.first_name) }
    before do
    	@staff = Staff.new(first_name: "John", last_name: "Smith", 
    	user_name: "smithjohn", password: "foobar", password_confirmation: "foobar",
        position: "admin")
    end

    subject { @staff }

    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:user_name) }
    it { should respond_to(:position) }

    it { should be_valid }

    describe "when user name is not present" do
    	before { @staff.user_name = " " }
    	it { should_not be_valid }
    end
    
    describe "when first name is not present" do
    	before { @staff.first_name = " " }
    	it { should_not be_valid }
    end

    describe "when last name is not present" do
    	before { @staff.last_name = " " }
    	it { should_not be_valid }
    end


    describe "when first name is too long" do
    	before { @staff.first_name = "a" * 51 }
    	it { should_not be_valid }
    end

    describe "when last name is too long" do
    	before { @staff.last_name = "a" * 51 }
    	it { should_not be_valid }
    end

    describe "when user name is already taken" do
    	before do
    	    staff_with_same_user_name = @staff.dup
    	    staff_with_same_user_name.save
        end

	   it { should_not be_valid }
    end

    describe "when password is not present" do
    	before { @staff.password = @staff.password_confirmation = " " }
    	it { should_not be_valid }
    end

    describe "when password doesn't match confirmation" do
    	before { @staff.password_confirmation = "mismatch" }
    	it { should_not be_valid }
    end

    describe "when password confirmation is nil" do
    	before { @staff.password_confirmation = nil }
    	it { should_not be_valid }
    end

    describe "with a password that's too short" do
    	before { @staff.password = @staff.password_confirmation = "a" * 5 }
    	it { should be_invalid }
    end

    describe "return value of authenticate method" do
    	before { @staff.save }
    	let(:found_staff) { Staff.find_by_first_name(@staff.first_name) }

        describe "with valid password" do
	        it { should == found_staff.authenticate(@staff.password) }
        end

        describe "with invalid password" do
        	let(:staff_for_invalid_password) { found_staff.authenticate("invalid") }

        	it { should_not == staff_for_invalid_password }
        	specify { staff_for_invalid_password.should be_false }
        end
    end

    describe "remember token" do
    	before { @staff.save }
    	its(:remember_token) { should_not be_blank }
    end
end
