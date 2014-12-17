module Api
class SessionsController < BaseController
  def create
    unless (params[:email] && params[:password]) || (params[:remember_token])
      return missing_params
    end

    @user = if params[:remember_token]
      user_from_remember_token
    else
      user_from_credentials
    end

    return invalid_credentials unless @user

    @user.ensure_authentication_token

    data = {
      user_id: @user.id,
      auth_token: @user.authentication_token
    }

    if params[:remember]
      @user.remember_me!
      data[:remember_token] = remember_token
    end

    render json: data, status: 201
  end

  def destroy
    return missing_params unless params[:auth_token]

    @user = User.find_by authentication_token: params[:auth_token]
    return invalid_credentials unless @user

    @user.reset_authentication_token!
    @user.forget_me!

    render json: { user_id: @user.id }, status: 200
  end

  def forgot
    if params[:email].blank?
      return missing_params
    elsif User.where(email: params[:email]).blank?
      return invalid_credentials
    else
      @user = User.send_reset_password_instructions(email: params[:email])
      render json: {}, status: 200
    end
  end

  private
  def user_from_remember_token
    id, identifier = params[:remember_token].split '-'
    User.serialize_from_cookie id, identifier
  end

  def user_from_credentials
    if user = User.find_for_database_authentication(email: params[:email])
      if user.valid_password? params[:password]
        user
      end
    end
  end

  def missing_params
    render json: {}, status: 400
  end
end
end
