module Api
class UsersController < BaseController
  before_action :auth_only!, except: [:create]
 # load_and_authorize_resource
 
  def create
    @user = User.new(user_params)
    @user.save
    UserMailer.signup_confirmation(@user).deliver
    respond_with(:api, @user)
  end

  def update
    @user = current_user
    @user.update_attributes(user_params) if @user
    respond_with(:api, @user)
  end

  def show
    @user = User.find(params[:id])
    respond_with(:api, @user)
  end

  protected
  def user_params
    params.require(:user) \
          .permit( :email, :password, :password_confirmation, :image)
  end
end
end
