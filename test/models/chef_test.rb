require 'test_helper'
class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "Ieva", email: "ieva@example.com", password: "12345", password_confirmation: "12345")
	end

	test "should be valid" do
		assert @chef.valid?		
	end

	test "name should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "password should be present" do
		@chef.password = @chef.password_confirmation = " "
		assert_not @chef.valid?
	end

	test "password should be at least 5 characters" do
		@chef.password = @chef.password_confirmation = "x" * 4
		assert_not @chef.valid?
	end


	test "name should be less than 30 characters" do
		@chef.chefname = "a" * 31
		assert_not @chef.valid?
	end

	test "email should be of correct format" do
		@chef.email = "email.email.com"
		assert_not @chef.valid?
	end

	test "email should be unique and case insensitive" do
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not duplicate_chef.valid?
	end

	test "email should be saved as lowercase" do
		mixed_case_email = "IeVa@EXample.COM"
		@chef.email = mixed_case_email
		@chef.save
		assert_equal mixed_case_email.downcase, @chef.reload.email
	end

end

