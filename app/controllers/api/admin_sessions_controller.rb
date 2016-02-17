module Api
class AdminSessionsController < BaseController

  def create
    unless (params[:email] && params[:password]) || (params[:auth_token])
      return missing_params
    end

    @user = AdminUser.find_by(email: params[:email])
    if @user.present?
      if @user.valid_password? (params[:password])
        @user.authentication_token = Devise.friendly_token
        @user.save
      end
    end
  end

  private

  def missing_params
    render json: "", status: 400
  end

end