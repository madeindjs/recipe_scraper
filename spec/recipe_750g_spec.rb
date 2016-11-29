require 'spec_helper'

describe RecipeCrawler do

  before(:each) do
    marmiton_url = 'http://www.750g.com/tarte-amandine-aux-pommes-dapi-r30157.htm'
    @recipe_750g = RecipeCrawler::Recipe.new marmiton_url
  end


  it 'should instanciante a recipe from 750g' do
    expect(@recipe_750g).not_to be nil
  end



  it 'should get the right title from 750g' do
    expect(@recipe_750g.title).to eq("Tarte Amandine aux Pommes d'Api")
  end


  it 'should get the right times' do
    expect(@recipe_750g.preptime).to eq(15)
    expect(@recipe_750g.cooktime).to eq(40)
  end


  it 'should get ingredients' do
    array_exepted = ["1 càs de sucre vanillé", "1 càs d'extrait de vanille", "30 grammes d'amandes effilées", "3 grosses pommes d'Api", "5 grammes de levure chimique", "80 grammes de sucre + un peu pour saupoudrer", "75 grammes de farine", "75 grammes de poudre d'amande", "100 grammes de beurre coupé en dés", "2 œufs"]
    expect(@recipe_750g.ingredients).to be_kind_of(Array)
    expect(@recipe_750g.ingredients).to eq array_exepted
  end


  it 'should get steps' do
    expect(@recipe_750g.steps).to be_kind_of(Array)
    expect(@recipe_750g.steps.include?('Bien mélanger.'))
  end

  it 'should get picture' do
    bretzel = RecipeCrawler::Recipe.new 'http://www.750g.com/bretzel-r3339.htm'
    expect(bretzel.image).to eq src="http://static.750g.com/images/auto-427/f3aa5fb6bb6f1059c4119c5b4cb0d720/bretzel.jpeg"
  end



  it 'should export all informations to json' do
    exepted_string = "{\"title\":\"Burger d'avocat\",\"preptime\":20,\"cooktime\":7,\"ingredients\":[\"2 beaux avocat\",\"2 steaks hachés de boeuf\",\"2 tranches de cheddar\",\"quelques feuilles de salade\",\"1/2 oignon rouge\",\"1 tomate\",\"graines de sésame\",\"1 filet d'huile d'olive\",\"1 pincée de sel\",\"1 pincée de poivre\"],\"steps\":[\"Laver et couper la tomate en rondelles\",\"Cuire les steaks à la poêle avec un filet d'huile d'olive\",\"Saler et poivrer\",\"Toaster les graines de sésames\",\"Ouvrir les avocats en 2, retirer le noyau et les éplucher\",\"Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat\",\"Parsemer quelques graines de sésames.\"],\"image\":\"http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg\"}"
    expect(@recipe_750g.to_json).to eq exepted_string
  end


  # it 'should convert a m.marmiton.org url into a valid url' do
  #   url = 'http://m.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
  #   recipe = RecipeCrawler::Recipe.new url
  #   expect(recipe).not_to be nil
  #   expect(recipe.title).to eq("Burger d'avocat")
  # end


end