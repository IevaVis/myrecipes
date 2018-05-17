class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]

	def index
		@recipes = Recipe.all
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = Chef.first
		if @recipe.save
			flash[:success] = "Recipe was created successfully!"
			redirect_to recipe_path(@recipe)
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			flash[:success] = "Recipe updated successfully!"
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	def destroy
		@recipe.destroy
		redirect_to recipes_path
		flash[:success] = "Recipe deleted successfully!" 
	end


	private
	def recipe_params
		params.require(:recipe).permit(:name, :description)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

end














