require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  describe "update_tweets" do


  end

  describe "make_or_find_from_json" do
    before(:each) do
      @json = { "id" => "123456", "screen_name" => "jcfischer"}
    end
    context "user doesn't exist" do
      it "should create a user" do
         User.make_or_find_from_json(@json).should be_instance_of(User)
      end 
    end

    context "user does exist" do
      before(:each) do
        @user = User.make(:login => 'jcfischer', :twitter_id => "123456")
      end

      it "should find the user" do
        User.make_or_find_from_json(@json).should == @user
      end
    end
  end
end
