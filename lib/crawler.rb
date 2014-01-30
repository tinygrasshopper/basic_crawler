class Crawler
  attr_reader :queue, :counter

  def initialize(queue, counter)
    @queue = queue
    @counter = counter
  end

  def crawl!
    item = queue.dequeue
    page = Page.fetch(item.url)
    counter.increment(item, page.input_count)

    normalize_urls(page, item).each do |link|
      queue.enqueue(Link.new(link, item))
    end
  end

  private
  def normalize_urls(page, item)
    initial = URI.parse(item.url)
    page.links.collect do |link|
      initial.merge(URI.parse(link)).to_s
    end
  end
end