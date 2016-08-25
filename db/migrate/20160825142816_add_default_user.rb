class AddDefaultUser < ActiveRecord::Migration
  def change
    user = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
    user.skip_confirmation!
    user.save
  end
end
