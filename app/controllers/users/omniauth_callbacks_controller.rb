class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_auth "Github"
  end

  def vkontakte
    handle_auth "Vkontakte"
  end

  def handle_auth(kind)
    binding.pry
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    @user = User.send(:"find_for_#{kind.downcased}_oauth", request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: kind
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.auth_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path, alert: "Failure. Please try again"
  end
end
