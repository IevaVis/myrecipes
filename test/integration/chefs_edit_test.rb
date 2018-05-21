require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest


def setup
	@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
	@chef2 = Chef.create!(chefname: "Fred", email: "fred@example.com", password: "12345", password_confirmation: "12345")
	@admin_user = Chef.create!(chefname: "John", email: "john@example.com", password: "12345", password_confirmation: "12345", admin: true)

end

test "reject an invalid edit" do
	sign_in_as(@chef, "12345")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef), params: { chef: { chefname: " ", email: "ieva@example.com"} }
 	assert_template 'chefs/edit'
 	assert_select 'h6.card-title'
 	assert_select 'div.card-body'

 end

 test "accept valid edit" do
 	sign_in_as(@chef, "12345")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef), params: { chef: { chefname: "Ieva", email: "ieva@example.com"} }
 	assert_redirected_to @chef
 	assert_not flash.empty?
 	@chef.reload
 	assert_match "Ieva", @chef.chefname
 	assert_match "ieva@example.com", @chef.email
 end

 test "accept edit attempt by admin user" do
 	sign_in_as(@admin_user, "12345")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef), params: { chef: { chefname: "Ieva1", email: "ieva1@example.com"} }
 	assert_redirected_to @chef
 	assert_not flash.empty?
 	@chef.reload
 	assert_match "Ieva1", @chef.chefname
 	assert_match "ieva1@example.com", @chef.email
 end

 test "redirect edit attempt by another non-admin user" do
 	sign_in_as(@chef2, "12345")
 	updated_name = "joe"
 	updated_email = "joe@example.com"
 	patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email} }
 	assert_redirected_to recipes_path
 	assert_not flash.empty?
 	@chef.reload
 	assert_match "Ieva", @chef.chefname
 	assert_match "ieva@example.com", @chef.email
 end


end

 