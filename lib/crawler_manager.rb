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
    @queue ||= LinkQueue.new(depth_limit, link_limit)
  end

  def input_counter
    @input_counter ||= InputCounter.new
  end

  def crawler
    @crawler ||= Crawler.new(queue, input_counter)
  end

  def depth_limit
    3
  end

  def link_limit
    50
  end
end