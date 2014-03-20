class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_gettext_locale

  private

    def set_gettext_locale
      # Fix me! the default locale is now chinese
      requested_locale = params[:locale] || session[:locale] || "zh-CN" #I18n.default_locale
      requested_locale = 'zh-CN' if %w(zh zh-tw zh_tw).include?(requested_locale.downcase)
      requested_locale = 'en-US' if %w(en en-gb en_gb).include?(requested_locale.downcase)
      locale = FastGettext.set_locale(requested_locale)
      I18n.locale = locale # some weird overwriting in action-controller makes this necessary ... see I18nProxy
      session[:locale] = I18n.locale.to_s
    end

end
