class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    sign_in_from_provider("facebook")
  end

  def twitter
    sign_in_from_provider("twitter")
  end

  def instagram
    sign_in_from_provider("instagram")
  end

  private

    def sign_in_from_provider(provider)
      existent_twitter_user = User.find_by_oauth_token(params[:oauth_token])
      if existent_twitter_user && provider == "twitter"
        @user = existent_twitter_user
      else
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if !@user.save
          set_flash_message(:notice, :error, kind: "#{provider}") if is_navigational_format?
        end
      end
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{provider}") if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

end
