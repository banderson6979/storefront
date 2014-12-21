module Api
class UsersController < BaseController
before_action :auth_only!, except: [:create, :new]

  def new
    @user = User.new(user_params)
    @user.save
    #MailchimpSync.new.add_email(@user.email) if @user.email.present?
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
          .permit(:email, :password, :password_confirmation,
                  :first_name, :last_name)
  end
end
end
