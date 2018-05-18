require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest


def setup
	@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
end

test "reject an invalid edit" do
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef), params: { chef: { chefname: " ", email: "ieva@example.com"} }
 	assert_template 'chefs/edit'
 	assert_select 'h6.card-title'
 	assert_select 'div.card-body'

 end

 test "accept valid edit" do
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef), params: { chef: { chefname: "Ieva", email: "ieva@example.com"} }
 	assert_redirected_to @chef
 	assert_not flash.empty?
 	@chef.reload
 	assert_match "Ieva", @chef.chefname
 	assert_match "ieva@example.com", @chef.email
 end
end

 