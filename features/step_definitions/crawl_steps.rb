When(/^I execute the crawler for site "([^"]*)"$/) do |url|
  @output = `bin/crawl #{url}`
end
Then(/^It should give the following output on the console$/) do |table|
  expect(@output.lines.count).to eq(table.hashes.size)
  table.hashes.each do |line|
    expect(@output).to match /#{line}/
  end
end