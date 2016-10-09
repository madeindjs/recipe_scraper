require 'spec_helper'

describe MarmitonCrawler do

  before(:each) do
    marmiton_url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
    @recipe = MarmitonCrawler::Recipe.new marmiton_url
  end

  it 'has a version number' do
    expect(MarmitonCrawler::VERSION).not_to be nil
  end

  it 'should create the recipe' do
    expect(@recipe).not_to be nil
  end

  it 'should not instanciante the recipe because it\'s not a marmiton.org url' do
    url = 'http://www.google.fr'
    expect{MarmitonCrawler::Recipe.new url}.to raise_error(ArgumentError)
  end

  it 'should get the right title' do
    expect(@recipe.title).to eq("Burger d'avocat")
  end



end