require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status do
  before(:each) do
    @valid_attributes = {
      :status_id => 1,
      :text => "value for text",
      :source => "value for source",
      :truncated => false,
      :in_reply_to_status_id => 1,
      :in_reply_to_user_id => 1,
      :favorited => false,
      :in_reply_to_screen_name => "value for in_reply_to_screen_name",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Status.create!(@valid_attributes)
  end
end
