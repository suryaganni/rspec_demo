require 'spec_helper'

describe User do

  it "with name presence" do
    FactoryGirl.create(:user).should be_valid
  end

  it "without name presence" do
    FactoryGirl.build(:user, :name => "").should_not be_valid
  end

  it "with email presence" do
    FactoryGirl.create(:user).should be_valid
  end

  it "without email presence" do
    FactoryGirl.build(:user, :email => "").should_not be_valid
  end

  it "with tasks presence" do
    FactoryGirl.build(:user, :tasks => [FactoryGirl.build(:task)]).should be_valid
  end

  it "without tasks presence" do
    FactoryGirl.build(:user, :tasks => []).should_not be_valid
  end

  it "delete a task from user" do
    user = FactoryGirl.create(:user, :tasks => [FactoryGirl.build(:task), FactoryGirl.build(:task)])
    user.should be_valid
    user_tasks = user.tasks
    task1 = user_tasks.first
    task2 = user_tasks.last
    user.tasks = [task2]
    user.save
    user.reload
    user.tasks.should eq([task2])
  end

  it "delete all task from user" do
    user = FactoryGirl.create(:user, :tasks => [FactoryGirl.build(:task), FactoryGirl.build(:task)])
    user.should be_valid
    user_tasks = user.tasks
    task1 = user_tasks.first
    task2 = user_tasks.last
    user.update_attributes({ :tasks_attributes => {} })
    user.reload
    user.tasks.should eq([task1, task2])
  end

end
