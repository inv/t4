require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status do

  describe "from_json" do

    before(:each) do
      @user = User.make
      @json = {"text" => "some tweet",
               "user" => {"id" => @user.twitter_id, "screen_name" => @user.login},
               "id" => 22334455,
               }
      @status =  Status.from_json @json
    end

    it "should create an object from a json hash" do
      @status.should be_instance_of(Status)
    end
    it "should assign the correct text" do
      @status.text.should == "some tweet"
    end

    it "should set the correct user" do
      @status.user.should == @user
    end
 
    it "should set the correct status id" do
      @status.status_id.should == 22334455;
    end
  end

  describe "from_json_array" do
    before(:each) do
      @array = [:status1, :status2]
      Status.stub(:from_json => true)
    end

    it "should call from_json for each element in array" do
      Status.should_receive(:from_json).twice
      Status.from_json_array @array
    end
  end
end
