class ChefsController < ApplicationController
	before_action :set_chef, only: [:show, :edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]

	def index
		@chefs = Chef.paginate(:page => params[:page], per_page: 5).order('created_at DESC')
	end

	def new
		@chef = Chef.new
	end

	def create
		@chef = Chef.new(chef_params)
		if @chef.save
			session[:chef_id] = @chef.id
			cookies.encrypted[:chef_id] = @chef.id
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
		if !@chef.admin?
			@chef.destroy
			flash[:danger] = "Chef and all associated recipes have been deleted successfully"
			redirect_to chefs_path
		end
	end

	private

	def chef_params
		params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
	end

	def set_chef
			@chef = Chef.find(params[:id])
	end

	def require_same_user
		if current_chef != @chef and !current_chef.admin?
			flash[:danger] = "You can only edit or delete your own profile"
			redirect_to recipes_path
		end
	end

	def require_admin
		if logged_in? and !current_chef.admin?
			flash[:danger] = "Only admin users can perform this action"
			redirect_to root_path
		end
	end

end