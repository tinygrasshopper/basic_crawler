require 'spec_helper'

describe CrawlerManager do
  let(:url) { 'http://google.com' }
  subject { described_class.new(url) }

  it 'should add the first link to the queue' do
    expect_any_instance_of(LinkQueue).to receive(:enqueue).with(Link.new(url, nil))

    subject.crawl!
  end

  it 'should call the crawler till the queue is empty' do
    allow_any_instance_of(LinkQueue).to receive(:has_elements?).and_return(true, true, true, false)

    expect_any_instance_of(Crawler).to receive(:crawl!).exactly(3).times

    subject.crawl!
  end

  it 'should return the inputs counter' do
    counter = double(InputCounter)
    allow(InputCounter).to receive(:new).and_return(counter)

    result = subject.crawl!
    expect(result).to eq(counter)
  end

end

