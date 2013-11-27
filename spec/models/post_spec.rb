require "spec_helper"

describe Post do

  it "has a valid name" do
    FactoryGirl.create(:post).should be_valid
  end

  it "has no name" do
    FactoryGirl.build(:post, name: "").should_not be_valid
  end

  it "has a valid subject" do
    FactoryGirl.create(:post).should be_valid
  end

  it "has no subject" do
    FactoryGirl.build(:post, subject: "").should_not be_valid
  end

end
