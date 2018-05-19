require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
 

 def setup
	@chef = Chef.create!(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
	@chef2 = Chef.create!(chefname: "Fred", email: "fred@example.com", password: "12345", password_confirmation: "12345")
end


test "should get chefs index page" do
  get chefs_path
  assert_response :success
end

test "should get chefs listing" do
  get chefs_path
  assert_template 'chefs/index'
  assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
  assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
end

test "should delete chef" do
	get chefs_path
	assert_template 'chefs/index'
	assert_difference 'Chef.count', -1 do
		delete chef_path(@chef2)
	end
	assert_redirected_to chefs_path
	assert_not flash.empty?
	end

end
