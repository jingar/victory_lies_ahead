require 'spec_helper'

describe "Heat pages" do

  subject { page }

  describe "index" do
    before do
      FactoryGirl.create(:heat, gender: "m", time: "01/04/2013 14:00:00")
      FactoryGirl.create(:heat, gender: "f", time: "01/04/2013 15:30:00")
      visit heats_path
    end

    it { should have_selector('title'), text: 'Hurdle Heats' }
    it { should have_selector('h1'), text: 'Hurdle Heats' }

    it "should list each heat" do
      Heat.all.each do |heat|
        page.should have_selector('li'), text: heat.time
      end
    end
  end

  describe "new hurdle heat page" do
    before { visit new_heat_path }

    it { should have_selector('h1'),    text: 'New Hurdle Heat' }
    it { should have_selector('title'), text: full_title('New Hurdle Heat') }
  end

  describe "new hurdle heat" do
    before { visit new_heat_path }
    let(:submit) { "create new heat" }

    describe "with invalid information" do
      it "should not create a heat" do
        expect { click_button submit }.not_to change(Heat, :count)
      end
    end

    describe "with valid information - heat" do
      before do
        fill_in :time, with: "05/04/2013 12:00:00"
        fill_in :gender, with: "m"
      end
      it "should create a heat" do
        expect { click_button submit }.to change(Heat, :count).by(1)
      end
    end
  end

  describe "heat display page" do
    let(:heat) { FactoryGirl.create(:heat) }
     before { visit heat_path }
     it { should have_selector('h1'), text: heat.time, text: heat.time }
    it { should have_selector('title'), text: heat.tim }
  end

    
  describe "edit" do
    let(:heat) { FactoryGirl.build(:heat) }
    before do
      visit edit_heat_path(heat)
    end

    describe "with valid information" do
      let(:new_time) { "04/05/2013 11:30:00" }
      let(:new_gender) { "f" }
      before do
        fill_in :time, with: new_time
        fill_in :gender, with: new_gender
        click_button "Save changes"
      end

      it { should have_selector('title'), text: new_time }
      it { should have_selector('div.alert.alert-success') }
      specify { time.reload.time.should == new_time }
      specify { heat.reload.gender.should == new_gender }
    end
  end
end
