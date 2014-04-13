# encoding: utf-8
module AirAware
  module Regexp
    # https://github.com/bcardarella/client_side_validations/issues/460
    # client_side_validations don't support space, so all the space should replace with "\x20"
    EMAIL = /\A[\-0-9a-z_.+]+@([\-0-9a-z_]+\.)+[\-0-9a-z_]+\z/i

    POSTCODE = /\A[0-9A-Z\x20-]*\z/

    PHONE = /\A(\s*?\+?\s*?\(?\s*?\+?\s*?\d{1,}[0-9\-\s]*?\)?)?\s*?[0-9\(\)]+?[0-9\s\(\)\-\+\.\*ext]*?\z/i
    PHONE_EXT = /\A(\s*?\+?\s*?\(?\s*?\+?\s*?\d{1,}[0-9\-\s]*?\)?)?\s*?[0-9\(\)]+?[0-9\s\(\)\-\+\.\*ext,]*?([\s\-\(]{1}.+?[\)]?)?\z/i

    URL = %r{\Ahttps?://[^/?:]+(:[0-9]{1,5})?(/?|(/[^/]+)*/?(\?[^\s"']+)?)\z}i
    URL_WITH_OPTIONAL_PROTOCOL = %r{\A(https?://)?[^/?:]+(:[0-9]{1,5})?(/?|(/[^/]+)*/?(\?[^\s"']+)?)\z}i
    URL_PATH = %r{\A(/|(/[^/]+)+/?(\?[^\s"']+)?)\z}i

    CAS_NUMBER = /\A[0-9]{2,7}-[0-9]{2}-[0-9]{1}\z/
    GIGA_NUMBER = /\A[0-9]{2}\.[0-9]{6}\z/

    CSI_CODE = /(\d*) (\d*) (\d*)\D{0,}[.]{0,1}(\d*)/
  end
end
