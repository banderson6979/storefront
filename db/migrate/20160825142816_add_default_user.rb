class AddDefaultUser < ActiveRecord::Migration
  def change
    user = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
    user.save
  end
end
