class CrawlerCLI
  def self.crawl! url
    counter = CrawlerManager.new(url).crawl!
    output = ''
    counter.links.each do |page, count|
      output << "#{page.url} - #{count} inputs\n"
    end
    output
  end
end