Given /^I am in (.*)$/ do |dir|
  @dir = dir
end

When /^I run cucumber (.*)$/ do |cmd|
  @dir ||= 'self_test'
  full_dir ||= File.expand_path(File.dirname(__FILE__) + "/../../examples/#{@dir}")
  Dir.chdir(full_dir) do
    @full_cmd = "#{Cucumber::RUBY_BINARY} #{Cucumber::BINARY} #{cmd}"
    @out = `#{@full_cmd}`
  end
end

Then /^the output should be$/ do |output|
  @out.should == output
end
