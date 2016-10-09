require 'net/http'

require "marmiton_crawler/version"

module MarmitonCrawler

  class Recipe

    MARMITON_HOST = 'http://www.marmiton.org/'

    def initialize(url)
      if url.include? MARMITON_HOST
        @url = url
        @html =  Net::HTTP.get URI(@url)
      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})." 
      end
    end
  
  end

end
