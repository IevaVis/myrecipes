class CreateChefs < ActiveRecord::Migration[5.2]
  def change
    create_table :chefs do |t|
    	t.string :chefname
    	t.string :email
    	t.string :password_digest
    	t.timestamps
    end
  end
end
