require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest

	def setup
		@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
	end
 
 test "invalid login is rejected" do
 	get login_path
 	assert_template 'sessions/new'
 	post login_path, params: { session: { email: " ", password: " "} }
 	assert_template 'sessions/new'
 	assert_not flash.empty?
 	get root_path
 	assert flash.empty?
 end

 test "valid login credentials accepted and begin session" do
 	get login_path
 	assert_template "sessions/new"
 	post login_path, params: { session: {email: "ieva@example.com", password: "12345"} }
 	assert_redirected_to @chef
 	follow_redirect!
 	assert_template 'chefs/show'
 	assert_not flash.empty?
 end

end
