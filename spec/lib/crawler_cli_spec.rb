require 'spec_helper'

describe CrawlerCLI do
  it 'should delegate to the crawler manger' do
    crawler_manager = double(CrawlerManager)
    expect(CrawlerManager).to receive(:new).with('http://temp').and_return(crawler_manager)
    expect(crawler_manager).to receive(:crawl!).and_return(double('result', pages: {}))

    CrawlerCLI.crawl! 'http://temp'
  end

  it 'should render the counter output' do
    expect_any_instance_of(CrawlerManager).to receive(:crawl!).and_return(double('result', pages: {'/one.html' => 2, '/two.html' => 1}))

    output = CrawlerCLI.crawl! 'http://temp'

    expect(output).to match /\/one.html - 2 inputs/
    expect(output).to match /\/two.html - 1 inputs/


  end
end