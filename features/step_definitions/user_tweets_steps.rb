Given /^there is a twitter user called '(.*?)'$/ do |login|
  @user = User.make :login => login
end

Given /^he has tweets$/ do
  5.times do |i|
    Status.make :user => @user
  end
end

Then /^I should see a list of tweets$/ do
  response.should have_tag "ul#tweets li"  
end
