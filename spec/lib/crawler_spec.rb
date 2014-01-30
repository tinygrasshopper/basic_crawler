require 'spec_helper'

describe Crawler do
  let(:queue) { LinkQueue.new(3, 3) }
  let(:counter) { InputCounter.new }
  subject { Crawler.new(queue, counter) }

  it 'should dequeue one item from the queue and fetch it' do
    link = Link.new('http://url', nil)

    expect(queue).to receive(:dequeue).and_return(link)
    expect(Page).to receive(:fetch).with(link.url).and_return(double(input_count: 4, links:[]))

    subject.crawl!
  end

  it 'should log if page fetch fails' do
    link = Link.new('http://url', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_throw('Exception')

    expect(Logger).to receive(:error).with('Failed http://url : uncaught throw "Exception"')
    subject.crawl!
  end

  it 'should add number of inputs to the input counter' do
    link = Link.new('http://url', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4, links:[]))

    expect(counter).to receive(:increment).with(link, 4)

    subject.crawl!
  end

  it 'should all local links on the page back to the queue' do
    link = Link.new('http://url/stuff/', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4, links: ['/about', 'index', '/new page']))

    expect(queue).to receive(:enqueue).with(Link.new('http://url/about', link))
    expect(queue).to receive(:enqueue).with(Link.new('http://url/stuff/index', link))
    expect(queue).to receive(:enqueue).with(Link.new('http://url/new%20page', link))

    subject.crawl!
  end

  it 'should not add page section links on the page back to the queue' do
    link = Link.new('http://url/stuff/', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4, links: ['#', '#index']))

    expect(queue).not_to receive(:enqueue)

    subject.crawl!
  end

  it 'should not add empty links on the page back to the queue' do
    link = Link.new('http://url/stuff/', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4, links: [nil, '']))

    expect(queue).not_to receive(:enqueue)

    subject.crawl!
  end

  it 'should not add external links page back to the queue' do
    link = Link.new('http://url/stuff/', nil)

    allow(queue).to receive(:dequeue).and_return(link)
    allow(Page).to receive(:fetch).and_return(double(Page, input_count: 4, links: ['http://google.com']))

    expect(queue).not_to receive(:enqueue)

    subject.crawl!
  end

end