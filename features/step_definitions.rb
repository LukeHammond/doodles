Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Given /^the following (.*) exists?:$/ do |factory, table|
#   step %Q|the #{factory} exists:|, table
# end

Given /^the following (.*) exists?:$/ do |factory, table|
  table.hashes.each do |hash|
    evaled_hash = {}
    hash.each do | k, v |
      # If the field ends with '_at' assume we want to evaluate the value as a Time expression
      if k =~ /_at$/ || ["true", "false"].include?(v)
        evaled_hash[k] = eval(v)
      else
        evaled_hash[k] = v
      end
    end
    Factory.create(factory.singularize.gsub(/ /, "_"), evaled_hash)
  end
end

Given /^I send and accept JSON$/ do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
end

When /^I send a POST request to (.*) with the following:$/ do |path, body|
  step "I send and accept JSON"
  begin
    post JsonSpec.memory_url(path), JsonSpec.remember(body)
  rescue TestException => e
    @exception = e
  end
end

When /^I send a PUT request to (.*) with the following:$/ do |path, body|
  step "I send and accept JSON"
  put JsonSpec.memory_url(path), JsonSpec.remember(body)
end

When /^I send a DELETE request to (.*) with the following:$/ do |path, body|
  step "I send and accept JSON"
  delete JsonSpec.memory_url(path), JsonSpec.remember(body)
end

Then /^the status code should be (.*)$/ do |status|
  last_response.status.should == status.to_i
end
