class CrawlerCLI
  def self.crawl! url
    counter = CrawlerManager.new(url).crawl!
    output = ''
    counter.pages.each do |page, count|
      output << "#{page} - #{count} inputs\n"
    end
    output
  end
end