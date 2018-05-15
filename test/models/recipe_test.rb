require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
		@recipe = @chef.recipes.build(name: "vegetable", description: "great recipe")
	end

	test "recipe should be valid" do
		assert @recipe.valid?	
	end

	test "recipe without chef should be invalid" do
		@recipe.chef_id = nil
		assert_not @recipe.valid?
	end

	test "name should be present" do
		@recipe.name = " "
		assert_not @recipe.valid?
	end

	test "description should be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description shouldn't be less than 5 characters" do
		@recipe.description = "a" * 3
		assert_not @recipe.valid?
	end

	test "description shouldn't be longer than 500 characters" do
		@recipe.description = "a" * 501
		assert_not @recipe.valid?
	end

end
