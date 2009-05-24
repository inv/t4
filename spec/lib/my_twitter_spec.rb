require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MyTwitter do

  before(:each) do
    @twitter = MyTwitter.new :some_token
  end
  describe "initialize" do

    it "should store the token" do
      @twitter.token.should == :some_token
    end

  end

  describe "get http response from twitter" do
    before(:each) do
      token = stub(:get => :some_response)
      @twitter = MyTwitter.new token
    end

    it "should call the get method on the token" do
      @twitter.response_from(:some_url).should == :some_response     
    end
  end

  describe "get timeline_url" do

    it "should return a correct timeline url" do
      @twitter.timeline_url_for("jcfischer").should == "http://twitter.com/statuses/user_timeline.json?screen_name=jcfischer"
    end
    
  end

  describe "parse_json_from" do
    before(:each) do
      JSON.stub!(:parse => :some_json)
      @response = stub(:body => :some_body)
    end
    it "should call JSON.parse" do
      JSON.should_receive(:parse).with(@response.body)
      @twitter.parse_json_from(@response)
    end
  end
  
  describe "get timeline from twitter" do
    before(:each) do
      @twitter.stub(:response_from => :some_response,
                    :timeline_url_for => :timeline_url,
                    :parse_json_from => :some_json )
    end
    it "should call timeline_url_for" do
      @twitter.should_receive(:timeline_url_for).with(:some_user)
      @twitter.get_timeline_for :some_user
    end
    it "should call response_from" do
      @twitter.should_receive(:response_from).with(:timeline_url)
      @twitter.get_timeline_for :some_user
    end
    it "should call parse_json_from" do
      @twitter.should_receive(:parse_json_from).with(:some_response)
      @twitter.get_timeline_for :some_user
    end
  end

end
