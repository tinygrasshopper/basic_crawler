class Crawler
  attr_reader :queue, :counter
  def initialize(queue, counter)
    @queue = queue
    @counter = counter
  end
  #
  def crawl!
    item = queue.dequeue
    page = Page.fetch(item.url)
    counter.increment(item, page.input_count)
  end
end