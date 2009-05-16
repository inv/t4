Given /^there is a twitter user called '(.*?)'$/ do |login|
  @user = User.make
end

Given /^he has tweets$/ do
  5.times do |i|
    Status.make {:user => @user}
  end
end


Given /^I click on 'jcfischer'$/ do
  pending
end

Then /^I should see a list of tweets$/ do
  pending
end
