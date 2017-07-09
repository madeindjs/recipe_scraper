# encoding: UTF-8
require 'json'
require 'open-uri'
require 'nokogiri'

require "recipe_scraper/version"


module RecipeScraper

  # represent a recipe fetched from an Url
  class Recipe

    attr_reader :title, :preptime, :cooktime , :ingredients, :steps, :image

    MARMITON_HOST = {desktop: 'http://www.marmiton.org/', mobile: 'http://m.marmiton.org/'}
    G750_HOST = {desktop: 'http://www.750g.com'}
    CUISINEAZ_HOST = {desktop: 'http://www.cuisineaz.com/'}



    # Instanciate a Recipe object with data crawled from an url
    #
    # @param url [String] representing an url from Marmiton or 750g website
    def initialize url

      if marmiton_host? url
        fetch_from_marmiton url

      elsif g750_host? url
        fetch_from_g750 url

      elsif cuisineaz_host? url
        fetch_from_cuisineaz url

      else
        raise ArgumentError, "Instantiation cancelled (Host not supported)."
      end
    end


    # export object properties to hash
    #
    # @return [Hash] as object's properties
    def to_hash
      attrs = Hash.new
      instance_variables.each do |var|
        str = var.to_s.gsub /^@/, ''
        attrs[str.to_sym] = instance_variable_get(var)
      end
      attrs
    end


    # convert object properties to json
    #
    # @return [String] data formated in JSON
    def to_json
      return self.to_hash.to_json
    end


    private


    # remove `\r\n` & unwanted espaces
    #
    # @param text [String] a text to sanitize
    # @return [String] as text corrected formated
    def sanitize text
      ['  ', '\r\n', "\r\n", "\n", "\r", "\t", / ^/, / $+/, /^  /, /^ /].each { |text_to_remove|
        text.gsub!(text_to_remove,'')
      }
      return text
    end


    # test if url is from a valid marmiton.org host
    #
    # @param url [String] representing an url
    # @return [Boolean] as true if coresponding to a valid url
    def marmiton_host? url
      return url.include?(MARMITON_HOST[:desktop]) || url.include?(MARMITON_HOST[:mobile])
    end


    # test if url is from a valid 750g.com host
    #
    # @param url [String] representing an url
    # @return [Boolean] as true if coresponding to a valid url
    def g750_host? url
      return url.include? G750_HOST[:desktop]
    end


    # test if url is from a valid cuisineaz.com host
    #
    # @param url [String] representing an url
    # @return [Boolean] as true if coresponding to a valid url
    def cuisineaz_host? url
      return url.include? CUISINEAZ_HOST[:desktop]
    end


    # fill object properties from a Marmiton url
    #
    # @param url [String] representing an url
    def fetch_from_marmiton url
      if marmiton_host? url

        url.gsub! MARMITON_HOST[:mobile], MARMITON_HOST[:desktop]

        page =  Nokogiri::HTML(open(url).read)
        @title = page.css('h1').text


        # get times
        @preptime = page.css('div.recipe-infos__timmings__preparation > span.recipe-infos__timmings__value').text.to_i
        @cooktime = page.css('div.recipe-infos__timmings__cooking > span.recipe-infos__timmings__value').text.to_i

        # get ingredients
        @ingredients = []
        ingredients_text = page.css('ul.recipe-ingredients__list li.recipe-ingredients__list__item').each do |ingredient_tag|
          @ingredients << sanitize(ingredient_tag.text)
        end

        # get steps
        @steps = []
        steps_text = page.css('ol.recipe-preparation__list').each do |step_tag|
          @steps << sanitize(step_tag.text)
        end

        # get image
        @image = page.css('#af-diapo-desktop-0_img').attr('src').to_s rescue NoMethodError

      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})."
      end
    end


    # fill object properties from a 750g url
    #
    # @param url [String] representing an url
    def fetch_from_g750 url
      if g750_host? url
        page =  Nokogiri::HTML(open(url).read)
        @title = page.css('h1.c-article__title').text

        # get times
        @preptime = page.css('ul.c-recipe-summary > li.c-recipe-summary__rating').text.to_i
        @cooktime = page.css('ul.c-recipe-summary > li.c-recipe-summary__rating').text.to_i

        @steps = []
        css_step = "div[itemprop=recipeInstructions] p"
        @steps = page.css(css_step).text.split /[( ),(<br>)]/

        @ingredients = []
        css_ingredient = "div.c-recipe-ingredients ul.c-recipe-ingredients__list li.ingredient"
        page.css(css_ingredient).each { |ing_node|
          @ingredients << sanitize(ing_node.text)
        }

        # get image
        css_image = 'div.swiper-wrapper img.photo'
        begin
          @image = page.css(css_image).attr('src').to_s
        rescue NoMethodError => e
        end

      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{G750_HOST})."
      end
    end


    # fill object properties from a 750g url
    #
    # @param url [String] representing an url
    def fetch_from_cuisineaz url
      if cuisineaz_host? url
        page =  Nokogiri::HTML(open(url).read)
        @title = page.css('h1').text

        # get times
        @preptime = page.css('#ctl00_ContentPlaceHolder_LblRecetteTempsPrepa').text.to_i
        @cooktime = page.css('#ctl00_ContentPlaceHolder_LblRecetteTempsCuisson').text.to_i

        @steps = []
        page.css("#preparation p").each { |step_node|
          @steps << sanitize(step_node.text)
        }

        @ingredients = []
        page.css("section.recipe_ingredients li").each { |ing_node|
          @ingredients << sanitize(ing_node.text)
        }

        begin
          @image = page.css('#ctl00_ContentPlaceHolder_recipeImgLarge').attr('src').to_s
        rescue NoMethodError => e
        end

      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{G750_HOST})."
      end
    end

  end

end
