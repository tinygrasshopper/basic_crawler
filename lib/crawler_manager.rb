class CrawlerManager
  def initialize url
    @url = url
    @counter_mutex = Mutex.new
    @working_count = 0
    @threads = []
  end

  def crawl!
    queue.enqueue(Link.new(@url, nil))
    start_threads
    wait_for_threads
    input_counter
  end

  def increment_working
    @counter_mutex.synchronize {
      @working_count = @working_count.next
    }
  end

  def decrement_working
    @counter_mutex.synchronize {
      @working_count = @working_count.pred
    }
  end

  def working_count
    @working_count
  end

  private
  def wait_for_threads
    @threads.each do |thread|
      thread.join
    end
  end

  def start_threads
    thread_count.times do
      @threads << Thread.new do
        CrawlerThread.new(self, crawler, queue).start
      end
    end
  end

  def queue
    @queue ||= LinkQueue.new(depth_limit, link_limit)
  end

  def input_counter
    @input_counter ||= InputCounter.new
  end

  def crawler
    Crawler.new(queue, input_counter)
  end

  def depth_limit
    3
  end

  def link_limit
    50
  end

  def thread_count
    5
  end
end