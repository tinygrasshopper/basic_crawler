class CrawlerManager
  def initialize url
    @url = url
  end

  def crawl!
    queue.enqueue(Link.new(@url, nil))
    while queue.has_elements?
      crawler.crawl!
    end

    input_counter
  end

  private

  def queue
    @queue ||= LinkQueue.new
  end

  def input_counter
    @input_counter ||= InputCounter.new
  end

  def crawler
    @crawler ||= Crawler.new(queue)
  end
end