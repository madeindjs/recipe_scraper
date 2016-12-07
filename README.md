# RecipeScraper

A web scrawler to get recipe data just by its web url: **RecipeScraper** support:

* [marmiton.org](http://www.marmiton.org/) 
* [750g.com](http://www.750g.com)
* [cuisineaz.com](http://www.cuisineaz.com)

You'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/recipe_scraper`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'recipe_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install recipe_scraper

## Usage

1. import library:

~~~ruby
require 'recipe_scraper'
~~~

2. Create a new instance of `RecipeScraper::Recipe`

~~~ruby
marmiton_url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
recipe = RecipeScraper::Recipe.new marmiton_url
~~~

3. Export as `json` or as an `Array` 

~~~ruby
recipe.to_hash
# will return
# --------------
# { :cooktime => 7,
#        :image => "http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg",
#        :ingredients => ["2 beaux avocat", "2 steaks hachés de boeuf", "2 tranches de cheddar", "quelques feuilles de salade", "1/2 oignon rouge", "1 tomate", "graines de sésame", "1 filet d'huile d'olive", "1 pincée de sel", "1 pincée de poivre"],
#        :preptime => 20,
#        :steps => ["Laver et couper la tomate en rondelles", "Cuire les steaks à la poêle avec un filet d'huile d'olive", "Saler et poivrer", "Toaster les graines de sésames", "Ouvrir les avocats en 2, retirer le noyau et les éplucher", "Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat", "Parsemer quelques graines de sésames."],
#        :title => "Burger d'avocat",
#  }
recipe.to_json
# will return
# --------------
# "{\"title\":\"Burger d'avocat\",\"preptime\":20,\"cooktime\":7,\"ingredients\":[\"2 beaux avocat\",\"2 steaks hachés de boeuf\",\"2 tranches de cheddar\",\"quelques feuilles de salade\",\"1/2 oignon rouge\",\"1 tomate\",\"graines de sésame\",\"1 filet d'huile d'olive\",\"1 pincée de sel\",\"1 pincée de poivre\"],\"steps\":[\"Laver et couper la tomate en rondelles\",\"Cuire les steaks à la poêle avec un filet d'huile d'olive\",\"Saler et poivrer\",\"Toaster les graines de sésames\",\"Ouvrir les avocats en 2, retirer le noyau et les éplucher\",\"Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat\",\"Parsemer quelques graines de sésames.\"],\"image\":\"http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg\"}"
~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madeindjs/recipe_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Author
----------

[Rousseau Alexandre](https://github.com/madeindjs)

