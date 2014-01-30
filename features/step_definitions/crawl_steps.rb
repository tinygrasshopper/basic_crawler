require_relative '../../lib/basic_crawler'

When(/^I execute the crawler for site "([^"]*)"$/) do |url|
  stub_pages()

  @output = CrawlerCLI.crawl!(url)
end

Then(/^It should give the following output on the console$/) do |table|
  expect(@output.lines.count).to eq(table.hashes.size)
  table.hashes.each do |line|
    expect(@output).to match /#{line}/
  end
end

def stub_page(page)
  stub_request(:get, "http://example.com/non_existant/#{page}").to_return(body: File.read("features/mock_site/#{page}"))
end

def stub_pages
  stub_page('page_1.html')
  stub_page('page_2.html')
  stub_page('page_3.html')
  stub_page('page_4.html')
end
