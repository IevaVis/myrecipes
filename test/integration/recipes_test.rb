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
	assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
	assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
end

test "create new valid recipe" do
	get new_recipe_path
	assert_template 'recipes/new'
	name_of_recipe = "chicken saute"
	description_of_recipe = "add chicken, add vegetables"
		assert_difference 'Recipe.count', 1 do
		post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe} }
	end
	follow_redirect!
	assert_match name_of_recipe.capitalize, response.body
	assert_match description_of_recipe, response.body
end

	test "reject invalid recipe submissions" do
		get new_recipe_path
		assert_template 'recipes/new'
		assert_no_difference 'Recipe.count' do
			post recipes_path, params: { recipe: {name: " ", description: " "} }
		end
		assert_template 'recipes/new'
		assert_select 'h6.card-title'
		assert_select 'div.card-body'
	end


end

































