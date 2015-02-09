module Api
class UsersController < BaseController
  before_action :auth_only!, except: [:create]
 # load_and_authorize_resource
 
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
    end
    
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
          .permit( :email, :password, :password_confirmation, :image,
                   :first_name, :last_name)
  end
end
end
