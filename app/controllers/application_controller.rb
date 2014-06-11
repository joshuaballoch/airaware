class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_gettext_locale

  class Error < StandardError; end
  class BadRequest < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class NotAcceptable < Error; end
  class UnsupportedMediaType < Error; end
  class ExpectationFailed < Error; end
  class UnprocessableEntity < Error; end
  class NotImplemented < Error; end

  rescue_from BadRequest do |e|
    head :bad_request
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        if request.xhr?
          head :forbidden
        elsif current_user.nil?
          flash.keep
          redirect_to new_user_session_path
        else
          redirect_to root_path, :alert => _("You to not have permission to access %{url}.") % {url: request.url}
        end
      end
      format.json { head :forbidden }
    end
  end

  rescue_from Forbidden do |e|
    head :forbidden
  end

  rescue_from NotFound do |e|
    head :not_found
  end

  rescue_from NotAcceptable do |e|
    head :not_acceptable
  end

  rescue_from UnsupportedMediaType do |e|
    head :unsupported_media_type
  end

  rescue_from ExpectationFailed do |e|
    head :expectation_failed
  end

  rescue_from UnprocessableEntity do |e|
    head :unprocessable_entity
  end

  rescue_from NotImplemented do |e|
    head :not_implemented
  end

  def authenticate_admin_user!
    unless AdminAuthorization.matches?(request)
      redirect_to root_path, :alert => _("Unauthorized Access!")
    end
  end

  private

    def set_gettext_locale
      # Fix me! the default locale is now chinese
      requested_locale = params[:locale] || session[:locale] || I18n.default_locale
      requested_locale = 'zh-CN' if %w(zh zh-tw zh_tw).include?(requested_locale.downcase)
      requested_locale = 'en-US' if %w(en en-gb en_gb).include?(requested_locale.downcase)
      locale = FastGettext.set_locale(requested_locale)
      I18n.locale = locale # some weird overwriting in action-controller makes this necessary ... see I18nProxy
      session[:locale] = I18n.locale.to_s
    end

end
