class LinkQueue
  attr_reader :depth_limit, :link_limit

  def initialize(depth_limit, link_limit)
    @queue = Queue.new
    @urls = []
    @depth_limit = depth_limit
    @link_limit = link_limit
  end

  def has_elements?
    ! count.zero?
  end

  def enqueue link
    @queue << link unless link.depth > depth_limit or @urls.size >= link_limit or @urls.include?(link.url)
    @urls << link.url
  end

  def count
    @queue.length
  end

  def dequeue
    @queue.pop
  end
end