require 'open-uri'
require 'nokogiri'

class Page
  def self.fetch url
    new(open(url).read)
  end

  attr_reader :content

  def initialize content
    @content = content
    @doc = Nokogiri::HTML(@content)
  end

  def input_count
    @doc.css('input').count
  end

  def links
    @doc.css('a').collect { |link| link['href'] }
  end
end