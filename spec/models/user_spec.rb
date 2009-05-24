require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  describe "update_tweets" do

    before(:each) do
      @user = User.new
    end

    it "should return true" do
      @user.update_tweets.should == true
    end
  end
end
