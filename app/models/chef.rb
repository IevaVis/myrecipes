class Chef < ApplicationRecord
	has_secure_password
	before_save {email.downcase!}
	validates :chefname, :email, :password, :password_confirmation, presence: true
	validates :chefname, length: { maximum: 30 }
	validates :email, uniqueness: {case_sensitive: false}
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	has_many :recipes
end