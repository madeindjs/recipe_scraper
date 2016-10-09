require 'open-uri'
require 'nokogiri'

require "marmiton_crawler/version"


module MarmitonCrawler

  class Recipe

    attr_reader :title

    MARMITON_HOST = 'http://www.marmiton.org/'

    def initialize(url)
      if url.include? MARMITON_HOST
        @page =  Nokogiri::HTML(open(url))
        @title = @page.css('h1.m_title span.item span.fn').text
      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})." 
      end
    end
  
  end

end
