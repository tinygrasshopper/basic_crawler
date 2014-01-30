class Crawler
  attr_reader :queue, :counter

  def initialize(queue, counter)
    @queue = queue
    @counter = counter
  end

  def crawl!
    item = queue.dequeue
    begin
      page = Page.fetch(item.url)
      counter.increment(item, page.input_count)

      normalize_urls(page, item).each do |link|
        queue.enqueue(Link.new(link, item))
      end
    rescue => e
      CrawlerLogger.error "Failed #{item.url} : #{e.to_s}"
    end
  end

  private
  def normalize_urls(page, item)
    initial = URI.parse(item.url)
    all_links = filtered_links(page).collect do |link|
      initial.merge(URI.parse(URI.encode(link)))
    end

    filter_external_links(all_links, initial).collect(&:to_s)
  end

  def filtered_links(page)
    filter_page_section_links(filter_invalid_links(page.links))
  end

  def filter_external_links(links, base)
    links.reject { |link| base.host != link.host }
  end

  def filter_invalid_links(links)
    links.reject { |link| link.nil? or link == '' }
  end

  def filter_page_section_links(links)
    links.reject { |link| link.start_with?('#') }
  end
end