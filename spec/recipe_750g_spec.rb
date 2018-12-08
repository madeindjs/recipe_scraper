require 'spec_helper'

describe 'http://www.750g.com recipe crawler' do
  before(:each) do
    marmiton_url = 'https://www.750g.com/tarte-amandine-aux-pommes-dapi-r30157.htm'
    @recipe_750g = RecipeScraper::Recipe.new marmiton_url
  end

   it 'should get the right people' do
    expect(@recipe_750g.nb_of_persons).to eq(6)
  end

  it 'should instanciante a recipe' do
    expect(@recipe_750g).not_to be nil
  end

  it 'should get the right title' do
    expect(@recipe_750g.title).to eq("Tarte Amandine aux Pommes d'Api")
  end

  it 'should get the right times' do
    expect(@recipe_750g.preptime).to eq(15)
    expect(@recipe_750g.cooktime).to eq(40)
  end

  it 'should get ingredients' do
    array_exepted = ['1 càs de sucre vanillé', "1 càs d'extrait de vanille", "30 grammes d'amandes effilées", "3 grosses pommes d'Api", '5 grammes de levure chimique', '80 grammes de sucre + un peu pour saupoudrer', '75 grammes de farine', "75 grammes de poudre d'amande", '100 grammes de beurre coupé en dés', '2 œufs']
    expect(@recipe_750g.ingredients).to be_kind_of(Array)
    expect(@recipe_750g.ingredients).to eq array_exepted
  end

  it 'should get steps' do
    expect(@recipe_750g.steps).to be_kind_of(Array)
    expect(@recipe_750g.steps.include?('Bien mélanger.'))
  end

  it 'should get picture' do
    bretzel = RecipeScraper::Recipe.new 'https://www.750g.com/bretzel-r3339.htm'
    expect(bretzel.image).to eq src = 'https://static.750g.com/images/auto-427/f3aa5fb6bb6f1059c4119c5b4cb0d720/bretzel.jpeg'
  end


end
