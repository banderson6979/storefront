class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def update()
    @user = User.find(params[:id])
    if params[:user][:password].blank?
      if @user.update_attributes(user_only_image)
        redirect_to root_path
      else
        render 'edit'
      end
    else
      if @user.update_attributes(user_params)
        redirect_to root_path
      else
        render 'edit'
      end
    end
  end

  private

    def user_params
      params.require(:user).permit( :email, :password, :password_confirmation, :image)
    end

    def user_only_image
      params.require(:user).permit(:image)
    end
end
