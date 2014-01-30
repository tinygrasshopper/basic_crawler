require 'spec_helper'

describe Crawler do
  let(:queue) { LinkQueue.new(3, 3) }
  let(:counter) { InputCounter.new }
  subject { Crawler.new(queue, counter) }

  it 'should dequeue one item from the queue and fetch it' do
    link = Link.new('http://url', nil)

    expect(queue).to receive(:dequeue).and_return(link)
    expect(Page).to receive(:fetch).with(link.url).and_return(double(input_count: 4))

    subject.crawl!
  end

  it 'should add number of inputs to the input counter' do
    link = Link.new('http://url', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4))
    expect(counter).to receive(:increment).with(link, 4)

    subject.crawl!
  end

end