require 'tempfile'

Given /^I am in (.*)$/ do |example_dir_relative_path|
  @current_dir = examples_dir(example_dir_relative_path)
end

Given /^a standard Cucumber project directory structure$/ do
  @current_dir = working_dir
  in_current_dir do
    FileUtils.mkdir_p 'features/support'
    FileUtils.mkdir 'features/step_definitions'
  end
end

Given /^the (.*) directory is empty$/ do |directory|
  in_current_dir do
    FileUtils.remove_dir(directory) rescue nil
    FileUtils.mkdir 'tmp'
  end
end

Given /^a file named "([^\"]*)"$/ do |file_name|
  create_file(file_name, '')
end

Given /^a file named "([^\"]*)" with:$/ do |file_name, file_content|
  create_file(file_name, file_content)
end

Given /^the following profiles? (?:are|is) defined:$/ do |profiles|
  create_file('cucumber.yml', profiles)
end

When /^I run cucumber (.*)$/ do |cucumber_opts|
  run "#{Cucumber::RUBY_BINARY} #{Cucumber::BINARY} --no-color #{cucumber_opts}"
end

When /^I run rake (.*)$/ do |rake_opts|
  run "rake #{rake_opts} --trace"
end

Then /^it should (fail|pass)$/ do |success|
  if success == 'fail'
    last_exit_status.should_not == 0
  else
    if last_exit_status != 0
      raise "Failed with exit status #{last_exit_status}\nSTDOUT:\n#{last_stdout}\nSTDERR:\n#{last_stderr}"
    end
  end
end

Then /^it should (fail|pass) with$/ do |success, output|
  last_stdout.should == output
  Then("it should #{success}")
end

Then /^the output should contain$/ do |text|
  last_stdout.should include(text)
end

Then /^the output should not contain$/ do |text|
  last_stdout.should_not include(text)
end

# http://diffxml.sourceforge.net/
Then /^"(.*)" should contain XML$/ do |file, xml|
  t = Tempfile.new('cucumber-junit')
  t.write(xml)
  t.flush
  t.close
  diff = `diffxml #{t.path} #{file}`
  if diff =~ /<delta>/m
    raise diff + "\nXML WAS:\n" + IO.read(file)
  end
end

Then /^"(.*)" should contain$/ do |file, text|
  IO.read(file).should == text
end

Then /^"(.*)" should match$/ do |file, text|
  IO.read(file).should =~ Regexp.new(text)
end

Then /^STDERR should match$/ do |text|
  last_stderr.should =~ /#{text}/
end

Then /^"(.*)" should exist$/ do |file|
  File.exists?(file).should be_true
  FileUtils.rm(file)
end

Then /^"([^\"]*)" should not be required$/ do |file_name|
  last_stdout.should_not include("* #{file_name}")
end

Then /^"([^\"]*)" should be required$/ do |file_name|
  last_stdout.should include("* #{file_name}")
end

