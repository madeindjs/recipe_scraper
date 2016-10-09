# encoding: UTF-8
require 'open-uri'
require 'nokogiri'

require "marmiton_crawler/version"


module MarmitonCrawler

  class Recipe

    attr_reader :title, :preptime, :cooktime , :ingredients, :steps

    MARMITON_HOST = 'http://www.marmiton.org/'

    def initialize(url)
      if url.include? MARMITON_HOST
        @page =  Nokogiri::HTML(open(url).read)
        @title = @page.css('h1.m_title span.item span.fn').text
        @preptime = @page.css('p.m_content_recette_info span.preptime').text.to_i
        @cooktime = @page.css('p.m_content_recette_info span.cooktime').text.to_i

        # get ingredients
        ingredients_text = @page.css('div.m_content_recette_ingredients').text
        @ingredients = sanitize(ingredients_text).split '- '
        @ingredients.delete_at(0) # to delete the first `Ingrédients (pour 2 personnes) :`

        # get steps
        steps_text = @page.css('div.m_content_recette_todo').text
        @steps = sanitize(steps_text).split '. '
        @steps.delete_at(0) # to delete the first `Ingrédients (pour 2 personnes) :`
        

      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})." 
      end
    end


    private

    # remove `\r\n` & unwanted espaces
    def sanitize text
      ['  ', '\r\n', "\r\n"].each { |text_to_remove| text.gsub!(text_to_remove,'')}
      return text
    end
  
  end

end
