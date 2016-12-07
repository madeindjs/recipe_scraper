require 'spec_helper'

describe RecipeScraper do

  it 'has a version number' do
    expect(RecipeScraper::VERSION).not_to be nil
  end

  it 'should not instanciante the recipe because it\'s not avalid host' do
    url = 'http://www.google.fr'
    expect{RecipeScraper::Recipe.new url}.to raise_error(ArgumentError)
  end

end