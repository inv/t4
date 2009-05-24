require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "List of twitter users" do

  # Called before each example.
  before(:each) do
    assigns[:users] = [User.make( :login => 'jcfischer')]
    render "static/index"
  end

  it "should be successful" do
    response.should be_success
  end

  it "should show twitter users" do
    response.should have_tag('ul li', :text => 'jcfischer')
  end

  it "should link to twitter user" do
    response.should have_tag('ul li span a[href=?]', user_path('jcfischer')) 
  end
end