class Api::V0::ApiController < ActionController::Base
  class Error < StandardError; end
  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class NotAcceptable < Error; end
  class UnsupportedMediaType < Error; end
  class ExpectationFailed < Error; end
  class UnprocessableEntity < Error; end
  class NotImplemented < Error; end

  before_filter :ensure_request_format

  rescue_from BadRequest do |e|
    head :bad_request
  end

  rescue_from Unauthorized do |e|
    head :unauthorized
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

  protected

    def ensure_request_format
      raise UnsupportedMediaType unless request.format == :json
    end
end
