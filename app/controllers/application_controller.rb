class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token, if: :json_request?
  def json_request?
    request.format.json?
  end

  #skip_before_filter :verify_authenticity_token

  # This is our new function that comes before Devise's one
  # before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_user!

  def current_user
    User.find_by_authentication_token(params[:auth_token]) || warden.authenticate(scope: :user)
  end

  def remember_token
    data = User.serialize_into_cookie @user
    "#{data.first.first}-#{data.last}"
  end

  private

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  def invalid_credentials
    render json: {}, status: 401
  end
end
