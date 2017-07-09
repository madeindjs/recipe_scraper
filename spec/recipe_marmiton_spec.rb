require 'spec_helper'

describe "http://www.marmiton.org recipe crawler" do

  before(:each) do
    marmiton_url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
    @recipe = RecipeScraper::Recipe.new marmiton_url
  end


  it 'should create the recipe' do
    expect(@recipe).not_to be nil
  end



  it 'should get the right title' do
    expect(@recipe.title).to eq("Burger d'avocat")
  end


  it 'should get the right times' do
    expect(@recipe.preptime).to eq(20)
    expect(@recipe.cooktime).to eq(7)
  end


  it 'should get ingredients' do
    array_exepted = ["2  avocats ", "2  steaks hachés de boeuf", "2 tranches de cheddar ", " feuille de salade ", "0.5  oignon rouge ", "1  tomate ", "  sésame ", "1 filet d'huile d'olive ", "1 pincée de sel ", "1 pincée de poivre ", "Voir les autres ingrédients", "2  avocats ", "2  steaks hachés de boeuf", "2 tranches de cheddar ", " feuille de salade ", "0.5  oignon rouge ", "1  tomate ", "  sésame ", "1 filet d'huile d'olive ", "1 pincée de sel ", "1 pincée de poivre "]
    expect(@recipe.ingredients).to be_kind_of(Array)
    expect(@recipe.ingredients).to eq array_exepted
  end


  it 'should get steps' do
    expect(@recipe.steps).to be_kind_of(Array)
    expect(@recipe.steps.include?('Laver et couper la tomate en rondelles'))
  end


  it 'should get image url' do
    expect(@recipe.image).to eq "https://image.afcdn.com/recipe/20160914/63596_w404h340c1cx2000cy3000.jpg"
  end


  it 'should export all informations to an array' do
    exepted_hash = { :cooktime => 7,
       :image => "https://image.afcdn.com/recipe/20160914/63596_w404h340c1cx2000cy3000.jpg",
       :ingredients => ["2  avocats ", "2  steaks hachés de boeuf", "2 tranches de cheddar ", " feuille de salade ", "0.5  oignon rouge ", "1  tomate ", "  sésame ", "1 filet d'huile d'olive ", "1 pincée de sel ", "1 pincée de poivre ", "Voir les autres ingrédients", "2  avocats ", "2  steaks hachés de boeuf", "2 tranches de cheddar ", " feuille de salade ", "0.5  oignon rouge ", "1  tomate ", "  sésame ", "1 filet d'huile d'olive ", "1 pincée de sel ", "1 pincée de poivre "],
       :preptime => 20,
       :steps => ["Laver et couper la tomate en rondelles", "Cuire les steaks à la poêle avec un filet d'huile d'olive", "Saler et poivrer", "Toaster les graines de sésames", "Ouvrir les avocats en 2, retirer le noyau et les éplucher", "Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat", "Parsemer quelques graines de sésames."],
       :title => "Burger d'avocat",
 }
    expect(@recipe.to_hash).to eq exepted_hash
  end



  it 'should a m.marmiton.org url into a valid url' do
    url = 'http://m.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'
    recipe = RecipeScraper::Recipe.new url
    expect(recipe).not_to be nil
    expect(recipe.title).to eq("Burger d'avocat")
  end


end
