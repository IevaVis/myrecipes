class ApplicationController < ActionController::Base
	helper_method :current_chef, :logged_in?

def current_chef
	#only if chef is logged in and this is stored in my browsers cookie will I have access to chef_id from the session hash
	@current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
end

def logged_in?
	# if current chef is here - true, othwerwise - false
	!!current_chef
end


def require_user
	if !logged_in?
		flash[:danger] = "You must be logged in to continue"
		redirect_to root_path
	end
end

end
