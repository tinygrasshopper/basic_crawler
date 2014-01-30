class CrawlerThread
  def initialize(manager, crawler, queue)
    @crawler = crawler
    @manager = manager
    @queue = queue
  end

  def start
    while (has_elements = @queue.has_elements?) or !@manager.working_count.zero?
      if has_elements
        @manager.increment_working
        @crawler.crawl!
        @manager.decrement_working
      else
        sleep(wait_time)
      end
    end
  end

  private
  def wait_time
    2
  end
end