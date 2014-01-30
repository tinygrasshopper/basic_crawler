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

  it 'should start 5 threads' do
    mock_thread = double(join: true)
    expect(Thread).to receive(:new).and_return(mock_thread).exactly(5).times

    subject.crawl!
  end

  it 'should wait till all threads finish' do
    mock_thread = double(Thread)
    allow(Thread).to receive(:new).and_return(mock_thread).exactly(5).times
    expect(mock_thread).to receive(:join).exactly(5).times

    subject.crawl!
  end

  it 'should return the inputs counter' do
    counter = double(InputCounter)
    allow_any_instance_of(LinkQueue).to receive(:has_elements?).and_return(false)
    allow(InputCounter).to receive(:new).and_return(counter)

    result = subject.crawl!
    expect(result).to eq(counter)
  end

  it 'should increment the working counter' do
    expect { subject.increment_working }.to change { subject.working_count }.from(0).to(1)
  end

  it 'should decrement the working counter' do
    expect { subject.decrement_working }.to change { subject.working_count }.from(0).to(-1)
  end

end

