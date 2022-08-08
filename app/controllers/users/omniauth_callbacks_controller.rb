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

  # def vkontakte
  #   binding.pry
  # 	@user = User.find_for_vkontakte_oauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte"
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session['devise.vkontakte_data'] = request.env['omniauth.auth'].except('extra')
  #     redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
  #   end
  # end

  # def github
  #   @user = User.find_for_github_oauth(request.env['omniauth.auth'])

  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session['devise.github_data'] = request.env['omniauth.auth'].except('extra')
  #     redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
  #   end
  # end

  # private

  # def omniauth_failure
  #   redirect_to new_user_registration_path, alert: I18n.t('omniauth.failure')
  # end
end
