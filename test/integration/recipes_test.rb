require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

def setup
	@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
	#two different ways to assign chef id to recipes
	@recipe = Recipe.create(name: "Vegetables", description: "Cooked vegetables", chef: @chef)
	@recipe2 = @chef.recipes.build(name: "Chicken saute", description: "Great chicken dish")
	@recipe2.save
end

test "should get recipes index" do
  get recipes_path
  assert_response :success
end

test "should get recipes listing" do
  get recipes_path
  assert_template 'recipes/index'
  assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
end

test "should get recipes show" do
	get recipe_path(@recipe)
	assert_template 'recipes/show'
	assert_match @recipe.name, response.body
	assert_match @recipe.description, response.body
	assert_match @chef.chefname, response.body
end


end
