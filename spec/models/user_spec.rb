require 'spec_helper'

describe User do
  before(:each) do
    @user = User.create!(:email => "neerajrails@gmail.com",:password => "123123123",:password_confirmation => "123123123",:username => "Neeraj",:first_name => "neeraj",:last_name => "chowdary")
  end
  
  context "Associations" do
    it "should have one notification" do
      should have_one(:notification).dependent(:destroy)
    end
    it "should have one store" do
      should have_one(:store).dependent(:destroy)
    end
    it "should have many social connections" do
      should have_many(:social_connections).dependent(:destroy)
    end
    it "should have many files" do
      should have_many(:files).dependent(:destroy)
    end
    it "should have many FileHandlers" do
      should have_many(:FileHandlers).dependent(:destroy)
    end
    it "should have many friends" do
      should have_many(:friends).dependent(:destroy)
    end
    it "should have many relationships" do
      should have_many(:relationships).dependent(:destroy)
    end
    it "should have many subscriptions" do
      should have_many(:subscriptions).through(:relationships)
    end
    it "should have many reverse_relationships" do
      should have_many(:reverse_relationships).dependent(:destroy)
    end
    it "should have many subscribers" do
      should have_many(:subscribers).through(:reverse_relationships)
    end
    it "should have many recommendations" do
      should have_many(:recommendations).dependent(:destroy)
    end
    it "should have many transactions" do
      should have_many(:transactions).dependent(:destroy)
    end
  end
  
  context "Validations" do
    it "should require username,first name and last name" do
      should validate_presence_of(:username)
      should validate_presence_of(:first_name)
      should validate_presence_of(:last_name)
      should validate_presence_of(:gender) if(:status == 'update')
    end
    
    it "username should be unique" do
      should validate_uniqueness_of(:username)
    end
  end
  
  context "callbacks" do

    it "should call the method after create" do
      should callback(:create_notification_settings).after(:create)
      should callback(:update_user_drawer).after(:create)
    end
    
  end
end
