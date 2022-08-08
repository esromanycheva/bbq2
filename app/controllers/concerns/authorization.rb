module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      if request.referer.present?
        redirect_to request.referer, alert: I18n.t('global.flash.not_authorized')
      else
        redirect_to root_path, alert: I18n.t('global.flash.not_authorized')
      end
    end
  end
end