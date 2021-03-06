require 'spec_helper'

describe Task do

  it "with name presence" do
    FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task)]).should be_valid
  end

  it "with name absence" do
    FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task, :name => "")]).should_not be_valid
  end

  it "with content presence" do
    FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task)]).should be_valid
  end

  it "with content absence" do
    FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task, :content => "")]).should_not be_valid
  end

  it "check without user existence" do
    task = FactoryGirl.build(:task, :user_id => nil)
    task.check_user_existence.should eq(false)
  end

  it "check with user existence" do
    task = FactoryGirl.create(:user, :tasks => [FactoryGirl.build(:task)]).tasks.first
    task.check_user_existence.should eq(nil)
  end

  it "check with task scope to destroy" do
    task = FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task)]).tasks.first
    task.valid_if_user_task.should eq(false)
  end

  it "check with user scope to destroy" do
    user = FactoryGirl.create(:user, :tasks => [FactoryGirl.build(:task)])
    task = user.tasks.first
    required_hash = task.attributes.reject{|r| ["created_at", "updated_at"].include?(r)}
    required_hash.merge!({"_destroy" => "1"})
    user.tasks_attributes = {"0"=> required_hash}
    user.tasks.first.valid_if_user_task.should eq(nil)
  end

end
