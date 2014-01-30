require 'spec_helper'

describe CrawlerThread do
  let(:counter) { InputCounter.new }
  let(:crawler) { Crawler.new(queue, counter) }
  let(:queue) { LinkQueue.new(3, 3) }
  let(:manager) { CrawlerManager.new('http://url') }

  subject { CrawlerThread.new(manager, crawler, queue) }

  it 'should call the crawler till the queue is empty' do
    allow(queue).to receive(:has_elements?).and_return(true, true, true, false)
    allow(manager).to receive(:working_count).and_return(0)

    expect(crawler).to receive(:crawl!).exactly(3).times

    subject.start
  end

  it 'should call the manager to increment the counter ' do
    allow(queue).to receive(:has_elements?).and_return(true, true, true, false)
    allow(manager).to receive(:working_count).and_return(0)
    allow(crawler).to receive(:decrement_working)
    allow(crawler).to receive(:crawl!)

    expect(manager).to receive(:increment_working).exactly(3).times

    subject.start
  end

  it 'should call the manager to decrement the counter ' do
    allow(queue).to receive(:has_elements?).and_return(true, true, true, false)
    allow(manager).to receive(:working_count).and_return(0)
    allow(crawler).to receive(:crawl!)

    expect(manager).to receive(:decrement_working).exactly(3).times

    subject.start
  end

  it 'should wait till managers working count is zero' do
    allow(queue).to receive(:has_elements?).and_return(false)
    allow(manager).to receive(:working_count).and_return(1, 1, 1, 0)

    subject.stub(:sleep)
    expect(subject).to receive(:sleep).with(2).exactly(3).times

    subject.start
  end

end