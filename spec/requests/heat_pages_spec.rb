require 'spec_helper'

describe "Heat pages" do

  subject { heat }

  describe "index" do
    before do
      FactoryGirl.create(:heat, gender: "m", time: "01/04/2013 14:00:00")
      FactoryGirl.create(:heat, gender: "f", time: "01/04/2013 15:30:00")
      visit heats_path
    end

    it { should have_selector('title'), text: 'Hurdle Heats' }
    it { should have_selector('h1'), text: 'Hurdle Heats' }

    it "should list each heat" do
      Heat.all.each do |user|
        page.should have_selector('li'), text: heat.time
        page.should have_selector('li'), text: heat.gender
      end
    end
  end

  describe "heat display page" do
    let(:heat) { FactoryGirl.create(:heat) }
     before { visit user_path(heat) }
     it { should have_selector('h1'), text: heat.time, text: heat.time }
    it { should have_selector('title'), text: heat.tim }
  end

  describe "with valid information - wattball" do
    before do
      fill_in "When", with: "05/04/2013 12:00:00"
      fill_in "Gender", with: "m"
    end
    it "should create a heat" do
      expect { click_button submit }.to change(Heat, :count).by(1)
    end
  end
    
  describe "edit" do
    let(:heat) { FactoryGirl.build(:heat) }
    before do
      visit edit_heat_path(heat)
    end
  end
end
