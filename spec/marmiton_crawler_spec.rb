require 'spec_helper'

describe MarmitonCrawler do
  it 'has a version number' do
    expect(MarmitonCrawler::VERSION).not_to be nil
  end

  it 'should instanciante  this ' do
    url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
    expect(MarmitonCrawler::Recipe.new url).not_to be nil
  end

  it 'should not instanciante  this ' do
    url = 'http://www.google.fr'
    expect{MarmitonCrawler::Recipe.new url}.to raise_error(ArgumentError)
  end

end