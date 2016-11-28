# encoding: UTF-8
require 'json'
require 'open-uri'
require 'nokogiri'

require "recipe_crawler/version"


module RecipeCrawler

  class Recipe

    attr_reader :title, :preptime, :cooktime , :ingredients, :steps, :image

    MARMITON_HOST = {desktop: 'http://www.marmiton.org/', mobile: 'http://m.marmiton.org/'}


    

    def initialize url
      if marmiton_host? url
        fetch_from_marmiton url
      else
        raise ArgumentError, "Instantiation cancelled (Host not supported)." 
      end
    end


    # export all informations to an array
    def to_hash
      attrs = Hash.new
      instance_variables.each do |var|
        str = var.to_s.gsub /^@/, ''
        attrs[str.to_sym] = instance_variable_get(var)
      end
      attrs
    end


    def to_json
      return self.to_hash.to_json
    end


    private

    # remove `\r\n` & unwanted espaces
    def sanitize text
      ['  ', '\r\n', "\r\n"].each { |text_to_remove| text.gsub!(text_to_remove,'')}
      return text
    end

    def marmiton_host? url
      return url.include?(MARMITON_HOST[:desktop]) || url.include?(MARMITON_HOST[:mobile])
    end

    # get data from an marmiton url
    def fetch_from_marmiton url
      if marmiton_host? url

        url.gsub! MARMITON_HOST[:mobile], MARMITON_HOST[:desktop]

        page =  Nokogiri::HTML(open(url).read)
        @title = page.css('h1.m_title span.item span.fn').text

        # get times
        @preptime = page.css('p.m_content_recette_info span.preptime').text.to_i
        @cooktime = page.css('p.m_content_recette_info span.cooktime').text.to_i

        # get ingredients
        ingredients_text = page.css('div.m_content_recette_ingredients').text
        @ingredients = sanitize(ingredients_text).split '- '
        @ingredients.delete_at(0) # to delete the first `Ingrédients (pour 2 personnes) :`

        # get steps
        steps_text = page.css('div.m_content_recette_todo').text
        @steps = sanitize(steps_text).split '. '
        @steps.delete_at(0) # to delete the first `Ingrédients (pour 2 personnes) :`

        # get image
        @image = page.css('a.m_content_recette_illu img.m_pinitimage').attr('src').to_s
        

      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})." 
      end
    end
  
  end

end
