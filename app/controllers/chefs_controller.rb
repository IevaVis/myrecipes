class ChefsController < ApplicationController
	before_action :set_chef, only: [:show, :edit, :update, :destroy]

	def index
		@chefs = Chef.paginate(:page => params[:page], per_page: 5).order('created_at DESC')
	end

	def new
		@chef = Chef.new
	end

	def create
		@chef = Chef.new(chef_params)
		if @chef.save
			flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
			redirect_to chef_path(@chef)
		else
			render :new
		end
	end

	def show
		@chef_recipes = @chef.recipes.paginate(:page => params[:page], per_page: 5).order('created_at DESC')
	end

	def edit
	end

	def update
		if @chef.update(chef_params)
			flash[:success] = "Chef account is updated"
			redirect_to chef_path(@chef)
		else
			render :edit
		end
	end

	def destroy
		@chef.destroy
		flash[:success] = "Account is deleted successfully"
		redirect_to recipes_path
	end

	private

	def chef_params
		params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
	end

	def set_chef
			@chef = Chef.find(params[:id])
	end

end